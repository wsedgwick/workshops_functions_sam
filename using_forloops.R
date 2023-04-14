# loading libs
library(tidyverse)
library(chron)
library(naniar)
library(here)
library(stringr)

# source function - calling function from global environment
source("utils/clean_ocean_temps.R")

# get list of files to iterate over
temp_files <- list.files(path = "data/raw_data", pattern = ".csv")

# for loop to read in data
for (i in 1:length(temp_files)) {
  
  # get object name from file name
  file_name <- temp_files[i]
  message("Reading in: ", file_name)
  split_name <- stringr::str_split_1(file_name, pattern = "_")
  site_name <- split_name[1]
  message("Saving as: ", site_name)
  
  # read in csv
  assign(x = site_name, value = read_csv(here::here("data", "raw_data", file_name)))
  
}








