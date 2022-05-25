# Bowang Lan

source('./summary_information.R')
library(tidyverse)
library(dplyr)

# Count total fire records in each state during during 1992-2015
fires_by_states <- fires %>%
  group_by(State) %>%
  count() %>% rename(Count = n) %>%
  arrange(-Count)

# States that have the top 10 number of fires during 1992-2015
states_with_top_10_total_count <- fires_by_states %>%
  head(10)

state_with_max_fire_count = head(fires_by_states, 1)
state_with_min_fire = tail(fires_by_states, 1)




#################
# Fires by year #
#################


# Bowang Lan

source('./summary_information.R')
library(tidyverse)
library(dplyr)

# Count total fire records in each state during during 1992-2015
fires_by_states <- fires %>%
  group_by(State) %>%
  count() %>% rename(Count = n) %>%
  arrange(-Count)

# States that have the top 10 number of fires during 1992-2015
states_with_top_5_total_count <- fires_by_states %>%
  head(5)

state_with_max_fire_count = head(fires_by_states, 1)
state_with_min_fire = tail(fires_by_states, 1)



#################
# Fires by year #
#################

# Total fire count for each year from 1992 to 2015
fires_by_year = fires %>%
  group_by(FireYear) %>%
  count() %>% rename(Count = n) %>%
  arrange(FireYear)
# Chart for the above: Line Plot, progression (chart 1)
ggplot(fires_by_year, aes(x=FireYear, y=Count)) +
  geom_area(fill = rgb(0, 0.5, 1, alpha = 0.5)) +
  scale_x_continuous(breaks=seq(from=1992, to=2015, by=1)) +
  theme(panel.grid.minor = element_blank()) +
  ggtitle('Total Fire Counts in US From 1992-2015')

# Years that have the top 10 fire count in US from 1992 to 2015
years_with_top_10_fire_count <- fires_by_year %>%
  arrange(-Count) %>%
  head(10)
years_with_top_10_fire_count$FireYear = as.character(years_with_top_10_fire_count$FireYear)
# Chart for the above: Bar Plot
ggplot(years_with_top_10_fire_count, aes(x=reorder(FireYear, -Count), y=Count)) +
  geom_col(fill=4) +
  geom_text(aes(label=Count), vjust=2, color='white') +
  ggtitle('Top 10 Years with the Most Fire counts in US during 1992-2015') +
  xlab('Year') +
  ylab('Fire Count')


#######
# Fires by fire size
# Chart file: chart2.R
#######

fires_by_fire_size_class = fires %>%
  group_by(FireSizeClass) %>%
  count() %>%
  rename(Count = n) %>%
  arrange(-Count)

fires_by_fire_size_class_and_year = fires %>%
  group_by(FireSizeClass, FireYear) %>%
  count() %>%
  rename(Count = n)



# What fires had the maximum fire size during 1992-2015?
top_10_biggest_fire <- fires %>%
  top_n(10, wt = FireSize) %>% # a handy dplyr function!
  arrange(-FireSize) %>%
  select(FireName, State, FireYear, FireSize, FireSizeClass)

# Fire count for each fire size class during 1992-2015
fire_size_class_count <- fires %>%
  group_by(FireSizeClass) %>%
  count() %>% 
  rename(Count = n)
colnames(fire_size_class_count) <- c("fire_size_class", "total_number") # Format column names


