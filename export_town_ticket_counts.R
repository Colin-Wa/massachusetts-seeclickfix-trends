install.packages("seeclickfixr")
install.packages("sf")
install.packages("mapview")
install.packages("raster")
install.packages("RColorBrewer")
install.packages('rgeos')

install.packages('ggmap')
install.packages('sp')
install.packages('maptools')

install.packages("tibble")
install.packages("data.table")

library(seeclickfixr)
library(sf)
library(mapview)
library(raster)
library(RColorBrewer)
library(rgeos)

library(ggmap)
library(sp)
library(maptools)

library(tibble)
library(data.table)

# Get all of the issues for each city

massachusetts_towns_in_seeclickfix <- subset(list_places("us-ma", limit=1000), (tolower(state) == "ma" | tolower(state) == "massachusetts") & tolower(place_type) == "city")

for(j in massachusetts_towns_in_seeclickfix$url_name)
{
  tryCatch(
    {
      print(paste("Starting ", j))
      issues_in_this_town <- get_city_issues(city=j, lat=NULL,long=NULL, status ="open,acknowledged,closed,archived", limit = 100000)
      issues_in_this_town %>%
        write.csv(file = paste("./Exports/town_tickets/town_",j,".csv",sep=""))
    },
    error = function(e)
    {
      print(paste("Error on ",j," with message ", e[1]))
    }
  )
  print(paste("Finished ", j))
}


file_names <- list.files("./Exports/town_tickets/")

ticket_counts_for_towns <- subset(massachusetts_towns_in_seeclickfix, select = -c(url, html_url, html_report_url, type))

towns_with_files <- file_names

for(j in 0:length(towns_with_files))
{
  towns_with_files[j] <- gsub('town_', '', towns_with_files[j])
  towns_with_files[j] <- gsub('.csv', '', towns_with_files[j])
}

ticket_counts_for_towns <- subset(ticket_counts_for_towns, url_name %in% towns_with_files)

number_of_years_prior <- 10

progress <- 0

total_loops <- number_of_years_prior * length(file_names)

add_column(ticket_counts_for_towns, x = "Total Tickets")


for(j in ticket_counts_for_towns$url_name)
{
  town_data_from_csv <- fread(paste("./Exports/town_tickets/town_",j,".csv",sep=""))
  
  ticket_counts_for_towns[ticket_counts_for_towns$url_name==j, "Total Tickets"] <- nrow(town_data_from_csv)
  
  for(i in 0:number_of_years_prior)
  {
    year_before <- (2023 - i)
    year_after <- (2024 - i)
    after_time <- as.POSIXlt(paste("01/01/", year_before, "00:00:00"), format="%d/%m/%Y %H:%M:%S")
    before_time <- as.POSIXlt(paste("01/01/", year_after, "00:00:00"), format="%d/%m/%Y %H:%M:%S")
    
    add_column(ticket_counts_for_towns, x = paste("Total Tickets ", year_before, sep = ""))
    add_column(ticket_counts_for_towns, x = paste("Total Closed ", year_before, sep = ""))
    add_column(ticket_counts_for_towns, x = paste("Total Open ", year_before, sep = ""))
    
    tickets_this_year <- subset(town_data_from_csv, created_at > after_time)
    tickets_this_year <- subset(tickets_this_year, created_at < before_time)
    
    ticket_counts_for_towns[ticket_counts_for_towns$url_name==j, paste("Total Tickets ", year_before, sep = "")] <- nrow(tickets_this_year)
    closed_issues <- subset(tickets_this_year, issue_status == "Closed" | (issue_status == "Archived" & !(is.na(closed_at))))
    open_issues <- subset(tickets_this_year, issue_status == "Open" | issue_status == "Acknowledged")
    ticket_counts_for_towns[ticket_counts_for_towns$url_name==j, paste("Total Closed ", year_before, sep = "")] <- nrow(closed_issues)
    ticket_counts_for_towns[ticket_counts_for_towns$url_name==j, paste("Total Open ", year_before, sep = "")] <- nrow(open_issues)
  }
}

ticket_counts_for_towns %>%
  write.csv(file ="./Exports/town_ticket_counts.csv")

