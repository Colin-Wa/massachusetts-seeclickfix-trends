# Requires export_town_ticket_counts.R to be run first (Uses town_ticket_counts.csv)

install.packages("sf")
install.packages("mapview")
install.packages("RColorBrewer")
install.packages("data.table")
install.packages("tibble")
install.packages("paletteer")

library(sf)
library(mapview)
library(RColorBrewer)
library(data.table)
library(tibble)
library(paletteer)

# Download and unzip municipality data from mass.gov

download.file("https://s3.us-east-1.amazonaws.com/download.massgis.digital.mass.gov/shapefiles/census2020/CENSUS2020TOWNS_SHP.zip" , destfile="Data/mass_town/towns.zip")

unzip(zipfile="Data/mass_town/towns.zip", exdir="Data/mass_town", overwrite = TRUE)

# Create a sf of the town survey layer with all of the town names

mass_towns <- read_sf(dsn = "./Data/mass_town/", layer = "CENSUS2020TOWNS_POLY")

# Display Massachusetts towns on a map

mapview(mass_towns, col.regions = brewer.pal(n = min(c(9, length(mass_towns))), name = "YlGnBu"), alpha.regions = 0.4, zcol = "TOWN20", legend = FALSE)



town_csv_data <- fread("./Exports/town_ticket_counts.csv")


# Town Total Ticket Heatmap

for (i in town_csv_data$name)
{
  town_csv_data[town_csv_data$name == i, "name"] = toupper(i)
  town_csv_data[town_csv_data$name == i, "name"] <- gsub("TOWN OF ", "", i)
  town_csv_data[town_csv_data$name == i, "name"] <- gsub("CITY OF ", "", i)
  town_csv_data[town_csv_data$name == i, "name"] <- gsub(", MA", "", i)
  town_csv_data[town_csv_data$name == i, "name"] <- gsub(" CENTER", "", i)
}

# Add columns to mass_towns_with_tickets

mass_towns_with_tickets <- mass_towns

mass_towns_with_tickets <- merge(mass_towns_with_tickets, town_csv_data, by.x = "TOWN20", by.y = "name", sort = TRUE)

# Sort mass_towns_with_tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets"), ]

# Map values with the mapview command



# Unscaled heatmap for Total Tickets

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets", legend = FALSE)

# Scaled heatmap for Total Tickets

add_column(mass_towns_with_tickets, x = "total_tickets_rank")

mass_towns_with_tickets$total_tickets_rank <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "total_tickets_rank", legend = FALSE)



# Unscaled heatmap for 2023 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2023"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2023", legend = FALSE)

# Scaled heatmap for 2023 Total Tickets

add_column(mass_towns_with_tickets, x = "2023_tickets_rank")

mass_towns_with_tickets$"2023_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2023_tickets_rank", legend = FALSE)



# Unscaled heatmap for 2022 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2022"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2022", legend = FALSE)

# Scaled heatmap for 2022 Total Tickets

add_column(mass_towns_with_tickets, x = "2022_tickets_rank")

mass_towns_with_tickets$"2022_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2022_tickets_rank", legend = FALSE)



# Unscaled heatmap for 2021 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2021"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2021", legend = FALSE)

# Scaled heatmap for 2021 Total Tickets

add_column(mass_towns_with_tickets, x = "2021_tickets_rank")

mass_towns_with_tickets$"2021_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2021_tickets_rank", legend = FALSE)




# Unscaled heatmap for 2020 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2020"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2020", legend = FALSE)

# Scaled heatmap for 2020 Total Tickets

add_column(mass_towns_with_tickets, x = "2020_tickets_rank")

mass_towns_with_tickets$"2020_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2020_tickets_rank", legend = FALSE)




# Unscaled heatmap for 2019 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2019"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2019", legend = FALSE)

# Scaled heatmap for 2019 Total Tickets

add_column(mass_towns_with_tickets, x = "2019_tickets_rank")

mass_towns_with_tickets$"2019_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2019_tickets_rank", legend = FALSE)



# Unscaled heatmap for 2018 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2018"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2018", legend = FALSE)

# Scaled heatmap for 2018 Total Tickets

add_column(mass_towns_with_tickets, x = "2018_tickets_rank")

mass_towns_with_tickets$"2018_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2018_tickets_rank", legend = FALSE)



# Unscaled heatmap for 2017 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2017"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2017", legend = FALSE)

# Scaled heatmap for 2017 Total Tickets

add_column(mass_towns_with_tickets, x = "2017_tickets_rank")

mass_towns_with_tickets$"2017_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2017_tickets_rank", legend = FALSE)



# Unscaled heatmap for 2016 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2016"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2016", legend = FALSE)

# Scaled heatmap for 2016 Total Tickets

add_column(mass_towns_with_tickets, x = "2016_tickets_rank")

mass_towns_with_tickets$"2016_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2016_tickets_rank", legend = FALSE)




# Unscaled heatmap for 2015 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2015"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2015", legend = FALSE)

# Scaled heatmap for 2015 Total Tickets

add_column(mass_towns_with_tickets, x = "2015_tickets_rank")

mass_towns_with_tickets$"2015_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2015_tickets_rank", legend = FALSE)



# Unscaled heatmap for 2014 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2014"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2014", legend = FALSE)

# Scaled heatmap for 2014 Total Tickets

add_column(mass_towns_with_tickets, x = "2014_tickets_rank")

mass_towns_with_tickets$"2014_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2014_tickets_rank", legend = FALSE)



# Unscaled heatmap for 2013 Total Tickets

mass_towns_with_tickets <- mass_towns_with_tickets[order(-mass_towns_with_tickets$"Total Tickets 2013"), ]

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "Total Tickets 2013", legend = FALSE)

# Scaled heatmap for 2013 Total Tickets

add_column(mass_towns_with_tickets, x = "2013_tickets_rank")

mass_towns_with_tickets$"2013_tickets_rank" <- 1:nrow(mass_towns_with_tickets)

mapview(mass_towns_with_tickets,col.regions = heat.colors(nrow(mass_towns_with_tickets)),zcol = "2013_tickets_rank", legend = FALSE)
