# Map chart for wildfires in the US in 2015

source('./summary_information.R')
library(tidyverse)
library(usmap)

# State count in 2015
state_count <- fires %>%
  filter(FireYear == "2015") %>%
  group_by(State) %>%
  count()
colnames(state_count) <- c("state", "number") # Format column names

# Plot the map
plot_usmap(data = state_count, value = "number") +
  ggtitle("Distribution of wildfires in 2015") +
  scale_fill_continuous(low ="white", high = "red", name = "Fires")