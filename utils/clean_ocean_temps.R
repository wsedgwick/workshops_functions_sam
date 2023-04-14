clean_ocean_temps <- function(raw_data, site_name, include_temps = c("Temp_top", "Temp_mid", "Temp_bot")) {
  
  # if data contains these cols, clean the script
  if(all(c("year", "month", "day", "decimal_time", "Temp_bot", "Temp_mid", "Temp_top") %in% colnames(raw_data))) {
    
    message("Cleaning data....")
    
    # format site name
    site_name_formatted <- paste(str_to_title(site_name), "Reef")
    
    # cols to select
    always_selected_cols <- c("year", "month", "day", "decimal_time")
    all_cols <- append(always_selected_cols, include_temps)
    
    # clean data
    temps_clean <- raw_data %>% 
      select(all_of(all_cols)) %>% 
      filter(year %in% c(2005:2020)) %>% 
      # add site column
      mutate(site = rep(site_name_formatted)) %>% 
      # create date-time column
      unite(col = date, year, month, day, sep = "-", remove = FALSE) %>%  # remove does not get rid of input columns
      mutate(time = times(decimal_time)) %>% 
      # combine data-time columns
      unite(col = date_time, date, time, sep = " ", remove = TRUE) %>% 
      mutate(date_time = as.POSIXct(date_time, "%Y-%m-%d %H:%M:%S", tz = "GMT"),
             year = as.factor(year),
             month = as.factor(month),
             day = as.numeric(day)) %>% 
      # replace 9999s with NAs
      replace_with_na(replace = list(Temp_bot = 9999, Temp_mid = 9999, Temp_top = 9999)) %>% 
      # add month name ----
    mutate(month_name = as.factor(month.name[month])) %>% 
      # reordering columns
      select(any_of(c("site", "date_time", "year", "month", "day", "month_name", "Temp_bot", "Temp_mid", "Temp_top")))
    
    # return clean data
    return(temps_clean)
    
  } else {
    
    stop("The data frame provides does not include the necessary columns. Please check your data.") # creates an error message
    
  }
  
}
