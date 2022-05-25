# Treemap for Causes of wildfires during 1992-2015

source('./summary_information.R')
library(tidyverse)
library(dplyr)

# This file deals with charts associated with Fire Causes

# Count the total causes of wildfires during 2012-2015
cause_bar = fires %>%
  group_by(StatCause) %>%
  count() %>%
  ggplot(aes(x=reorder(StatCause, n), y=n)) +
  geom_col() +
  scale_y_continuous(limits=c(0, 4.6e+05)) +
  xlab('Fire Cause') +
  ylab('Fire Count') +
  ggtitle('Total Fire Counts during 1992-2015 for each Fire Cause') +
  coord_flip()

# The progression of fire counts for each cause from 1992 to 2015
cause_progression = fires %>%
  group_by(FireYear, StatCause) %>%
  count() %>%
  ggplot(aes(x=FireYear, y=n, color=StatCause)) +
  geom_line() +
  geom_point() +
  scale_x_continuous(breaks=seq(from=1992, to=2015, by=2)) +
  xlab('Year') +
  ylab('Count')
