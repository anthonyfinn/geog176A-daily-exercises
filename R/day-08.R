#LIAM FINN
#August 13th, 2020
#Daily assignment #8

install.packages('zoo')
library(zoo)
(x = c(1:20))

#load data from NY Times
library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)
head(covid)                                 #check data loaded correctly

#classify data into state/region
region = data.frame(state = state.name, region = state.region)
head(region)

#replicating NY Times Article
#Question 1: Plot the daily new cases overlaid with a 7-day rolling mean for a state of your choice

state.of.interest = "Texas"
covid %>%
  filter(state == state.of.interest)%>%  #filter Texas COVID cases by county
  group_by(date) %>%  #new cases by DAY (sums up total new cases for all counties)
  summarise(cases = sum(cases)) %>%
  mutate(newCases = cases - lag(cases),
         roll7 = rollmean(newCases, 7, fill = NA, align="right")) %>%
  ggplot(aes(x = date)) +
  geom_col(aes(y = newCases), col = NA, fill = "#F5B8B5") +
  geom_line(aes(y = roll7), col = "darkred", size = 1) +
  ggthemes::theme_excel_new() +
  labs(title = paste("New Reported cases by day in", state.of.interest)) +
  theme(plot.background = element_rect(fill = "white"),
        panel.background = element_rect(fill = "white"),
        plot.title = element_text(size = 14, face = 'bold')) +
  theme(aspect.ratio = .5)
