# Summary Information Script

library(tidyverse)
library(ggplot2)
library(dplyr)

# Read Fire dataset from 2012 - 2015
fire_2012_2015_df <- read.csv("data/Fires_2012_2015.csv")

# A function that takes in a dataset and returns a list of info about it:
summary_info <- list()
summary_info$num_observations <- nrow(fire_2012_2015_df)
summary_info$num_columns <- ncol(fire_2012_2015_df)

# Which fire has the maximum fire size during 2012-2015?
summary_info$max_fire_size <- fire_2012_2015_df %>%
  filter(FIRE_SIZE == max(FIRE_SIZE, na.rm = T)) %>%
  select(FIRE_NAME, STATE, FIRE_YEAR, FIRE_SIZE, FIRE_SIZE_CLASS)

# What 10 fires had the maximum fire size during 2012-2015?
summary_info$top_10_biggest_fire_size <- fire_2012_2015_df %>%
    top_n(10, wt = FIRE_SIZE) %>% # a handy dplyr function!
    arrange(-FIRE_SIZE) %>%
    select(FIRE_NAME, STATE, FIRE_YEAR, FIRE_SIZE, FIRE_SIZE_CLASS)

# Count the total fire size class during 2012-2015
fire_size_class_count <- fire_2012_2015_df %>%
  group_by(FIRE_SIZE_CLASS) %>%
  count()
colnames(fire_size_class_count) <- c("fire_size_class", "total_number") # Format column names

# Which fire size class happened the most during 2012-2015
summary_info$fire_size_class_max <- fire_size_class_count %>%
  filter(total_number == max(fire_size_class_count$total_number, na.rm = T)) %>%
  select(fire_size_class, total_number)

# Which fire size class happened the least during 2012-2015
summary_info$fire_size_class_min <- fire_size_class_count %>%
  filter(total_number == min(fire_size_class_count$total_number, na.rm = T)) %>%
  select(fire_size_class, total_number)

# Count the total fire in each state during 2012-2015
state_fire_count <- fire_2012_2015_df %>%
  group_by(STATE) %>%
  count() %>%
  arrange(-n)
colnames(state_fire_count) <- c("state", "number_of_fires")

# Which state had the most wildfires during 2012-2015
summary_info$state_fire_count_max <- state_fire_count %>%
  filter(number_of_fires == max(state_fire_count$number_of_fires, na.rm = T)) %>%
  select(state, number_of_fires)

# Which state had the least wildfires during 2012-2015
summary_info$state_fire_count_min <- state_fire_count %>%
  filter(number_of_fires == min(state_fire_count$number_of_fires, na.rm = T)) %>%
  select(state, number_of_fires)