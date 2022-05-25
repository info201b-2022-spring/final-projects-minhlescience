# Map chart for wildfires in the US in 2015

source('./aggregate.R')
library(tidyverse)
library(usmap)

# State count in 2015
state_count <- fires %>%
  filter(FireYear == "2015") %>%
  group_by(State) %>%
  count()
colnames(state_count) <- c("state", "number") # Format column names

# Plot the map
current_map = plot_usmap(data = state_count, value = "number") +
  ggtitle("Distribution of wildfires in 2015") +
  scale_fill_continuous(low ="white", high = "red", name = "Fires")


top_5_state_progression = fires %>%
  group_by(State, FireYear) %>%
  count() %>%
  rename(Count = n) %>%
  filter(State %in% states_with_top_5_total_count$State) %>%
  ggplot(aes(x=FireYear, y=Count, color=State)) +
  geom_line() +
  geom_point() +
  ggtitle("Progression of the Top-5 States with the Most Fire Count During 1992-2015") +
  xlab('Year') +
  ylab('Fire Count')
