# Flights Database clean and tidy

library(tidyverse)

flights <- read_csv("Flights-Database.csv")

# test that flights are unique
#test <- distinct(flights, Date)

# most information I require is in dogs data
# extract variables for joining to dog data

flights_tidy <- flights %>% 
  clean_names() %>% 
  select(date_flight = date, rocket, altitude_km, result, notes_flight = notes) %>% 
  mutate(altitude = parse_number(altitude_km))
