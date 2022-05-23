source('./summary_information.R')
library(dplyr)

fires_by_states = fires %>%
  group_by(State) %>%
  summarize(Count = n()) %>%
  arrange(-Count)

state_with_max_fire_count = head(fires_by_states, 1)
state_with_min_fire = tail(fires_by_states, 1)

fires_by_year = fires %>%
  group_by(FireYear) %>%
  summarise(Count = n()) %>%
  arrange(FireYear)

year_with_most_fires = fires_by_year %>% arrange(-Count) %>% head(1)
year_with_least_fires = fires_by_year %>% arrange(Count) %>% head(1)
mean_fire_count_per_year = as.integer(mean(fires_by_year$Count))


fires_by_state_and_year = fires %>%
  group_by(State, FireYear) %>% 
  summarise(Count = n()) %>%
  arrange(FireYear)

# the year with most fire count in each state
states_year_with_most_fires = fires_by_state_and_year %>%
  group_by(State) %>%
  summarize(MaxYearCount = max(Count), MaxYear = fires_by_state_and_year[which.max(Count)])

fires_by_size_class = fires %>%
  group_by(FireSizeClass) %>%
  summarise(Count = n())


fires_by_state_and_size_class = fires %>%
  group_by(FireSizeClass, State) %>%
  summarise(Count = n())
