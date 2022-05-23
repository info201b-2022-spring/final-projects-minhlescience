# Bowang Lan

library(sqldf)
library(tidyverse)

sql = '
select 
  FIRE_NAME as FireName,
  STATE as State, 
  COUNTY as County, 
  LATITUDE as Latitude, 
  LONGITUDE as Longitude, 
  FIRE_YEAR as FireYear, 
  FIRE_SIZE as FireSize, 
  FIRE_SIZE_CLASS as FireSizeClass, 
  FOD_ID as Id, 
  STAT_CAUSE_DESCR as StatCause
from fires
'
con <- dbConnect(RSQLite::SQLite(), './data/FPA_FOD_20170508.sqlite')
fires <- dbFetch(dbSendQuery(con, sql))
dbDisconnect(con)

summary_info <- list()
summary_info$total_fire_record_count = count(fires)$n
summary_info$max_fire_size = max(fires$FireSize)
summary_info$min_fire_size = min(fires$FireSize)
summary_info$mean_fire_size = mean(fires$FireSize)
summary_info$fire_size_class_count = length(unique(fires$FireSizeClass))
summary_info$start_year = min(fires$FireYear)
summary_info$end_year = max(fires$FireYear)

# MINH TRUNG LE

# Which fire has the maximum fire size during 1992-2015?
summary_info$max_fire_size <- fires %>%
  filter(FireSize == max(FireSize, na.rm = T)) %>%
  select(FireName, State, FireYear, FireSize, FireSizeClass)

# What 10 fires had the maximum fire size during 1992-2015?
summary_info$top_10_biggest_fire_size <- fires %>%
  top_n(10, wt = FireSize) %>% # a handy dplyr function!
  arrange(-FireSize) %>%
  select(FireName, State, FireYear, FireSize, FireSizeClass)

# Count the total fire size class during 1992-2015
fire_size_class_count <- fires %>%
  group_by(FireSizeClass) %>%
  count()
colnames(fire_size_class_count) <- c("FireSizeClass", "total_number") # Format column names

# Which fire size class happened the most during 1992-2015
summary_info$fire_size_class_max <- fire_size_class_count %>%
  filter(total_number == max(fire_size_class_count$total_number, na.rm = T)) %>%
  select(FireSizeClass, total_number)

# Which fire size class happened the least during 1992-2015
summary_info$fire_size_class_min <- fire_size_class_count %>%
  filter(total_number == min(fire_size_class_count$total_number, na.rm = T)) %>%
  select(FireSizeClass, total_number)

# Count the total fire in each state during 1992-2015
state_fire_count <- fires %>%
  group_by(State) %>%
  count() %>%
  arrange(-n)
colnames(state_fire_count) <- c("state", "number_of_fires")

# Which state had the most wildfires during 1992-2015
summary_info$state_fire_count_max <- state_fire_count %>%
  filter(number_of_fires == max(state_fire_count$number_of_fires, na.rm = T)) %>%
  select(state, number_of_fires)

# Which state had the least wildfires during 1992-2015
summary_info$state_fire_count_min <- state_fire_count %>%
  filter(number_of_fires == min(state_fire_count$number_of_fires, na.rm = T)) %>%
  select(state, number_of_fires)