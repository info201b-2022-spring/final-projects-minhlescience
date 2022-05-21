source('./summary_information.R')
library(dplyr)

fires_by_states = fires %>%
  group_by(State) %>%
  count() %>%
  arrange(-n)

# state_with_max_fire_count = head(fires_by_states, 1)$State
state_with_max_fire_count = fires_by_states$State[[1]]

fires_by_year = fires %>%
  group_by(FireYear) %>%
  count()