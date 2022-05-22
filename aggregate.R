# Bowang Lan

source('./summary_information.R')
library(tidyverse)
library(dplyr)

# Top 10 number of fires by states
fires_by_states = fires %>%
  group_by(State) %>%
  count() %>%
  arrange(-n) 

fires_by_states <- fires_by_states %>%
  filter(State %in% fires_by_states$State[1:10])

# Top 10 number of fires by year
fires_by_year = fires %>%
  group_by(FireYear) %>%
  count() %>%
  arrange(-n)
  
fires_by_year <- fires_by_year %>%
  filter(FireYear %in% fires_by_year$FireYear[1:10])

# MINH TRUNG LE

# What 10 fires had the maximum fire size during 1992-2015?
top_10_biggest_fire_size <- fires %>%
  top_n(10, wt = FireSize) %>% # a handy dplyr function!
  arrange(-FireSize) %>%
  select(FireName, State, FireYear, FireSize, FireSizeClass)

# Count the total fire size class during 1992-2015
fire_size_class_count <- fires %>%
  group_by(FireSizeClass) %>%
  count()
colnames(fire_size_class_count) <- c("fire_size_class", "total_number") # Format column names

# Count the total fire in each state during 1992-2015
state_fire_count <- fires %>%
  group_by(State) %>%
  count() %>%
  arrange(-n)
colnames(state_fire_count) <- c("State", "Number_of_fires")