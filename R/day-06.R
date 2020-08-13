#LIAM FINN
#August 12th, 2020
#Daily assignment #6
library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)
head(covid)

install.packages("ggplot2")
library(ggplot2)

covid %>%
  filter(date == max(date)) %>%
  group_by(state) %>%
  summarize(cases = sum(cases, na.rm = TRUE)) %>%
  ungroup() %>%
  slice_max(cases, n = 6) %>%
  pull(state)
covid %>%
  filter(state %in% c("California", "Florida", "Texas", "New York", "Georgia", "Illinois")) %>%
  ggplot(aes(x = date, y = cases)) +
  geom_line(aes(color = state)) +
  facet_wrap(~state) +
  theme_classic() +
  labs(title = "Cummulative Case Counts",
       subtitle = "Data Source: NY-Times",
       x = "Date",
       y = "Cases",
       caption = "Daily Exercise 06")

covid %>%
  group_by(date) %>%
  summarize(cases = sum(cases)) %>%
  ggplot(aes(x = date, y = cases)) +
  geom_col(fill = "blue", color = "blue", alpha = .25) +
  geom_line(color = "blue", size = 3) +
  ggthemes::theme_gdocs() +
  labs(title = "National Cummulative Case Counts",
       x = "Date",
       y = "Cases",
       caption = "Daily Exercise 06")
