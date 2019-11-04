# Dogs Database clean and tidy

library(tidyverse) # most things
library(lubridate) # format dates 
library(janitor) # cleaning things

# read in dogs csv files
# from: https://airtable.com/universe/expG3z2CFykG1dZsp/sovet-space-dogs

dogs <- read_csv("Dogs-Database.csv")

dogs

# pipeline to clean and make tidy the dataset

dogs_tidy <- dogs %>% 
  # clean names to snake_case
  clean_names() %>% 
  # flights are recorded on same row - put on separate rows to make it 'tidy'
  separate_rows(flights, sep = ",") %>% 
  # format data
  mutate(date_flight = ymd(flights),
         # from fate variable extract the date if dog died
         date_death = case_when(str_sub(fate, 1, 4) == "Died" ~ str_sub(fate, 6, 15)),
         date_death = ymd(date_death),
         # if dog died on flight then set flight_fate to Died
         flight_fate = case_when(date_flight == date_death ~ "Died",
                          TRUE ~ "Survived")) %>% 
  # put notes at end of columns, remove fate (replaced by flight_fate)
  select(-notes, everything(), -fate)

# Note: Rita has 2 death dates provided, but only the first one is same as flight date so
# I have taken that as the date of death

head(dogs_tidy)

range(dogs_tidy$date_flight)
count(dogs_tidy, flight_fate)

# Data is no longer unique by dog, but unique by dog-flight combination
# To be joined to flights data for more information




