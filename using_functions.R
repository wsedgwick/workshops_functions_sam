# loading libs
library(tidyverse)
library(chron)
library(naniar)
library(here)
library(stringr)

# source function - calling function from global environment
source("utils/clean_ocean_temps.R")

# import data ----
alegria <- read_csv(here("data", "raw_data", "alegria_mooring_ale_20210617.csv"))
carpinteria <- read_csv(here("data", "raw_data", "carpinteria_mooring_car_20220330.csv"))
mohawk <- read_csv(here("data", "raw_data", "mohawk_mooring_mko_20220330.csv"))

# clean data
alegria_clean <- clean_ocean_temps(raw_data = alegria, site_name = "alegria")
mohawk_clean <- clean_ocean_temps(mohawk, "MOHAWK", include_temps = c("Temp_bot"))
carpinteria_clean <- clean_ocean_temps(carpinteria, "Carpinteria", include_temps = c("Temp_top", "Temp_bot"))



