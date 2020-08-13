#LIAM FINN
#August 13th, 2020
#Daily assignment #7

#load data from NY Times
library(tidyverse)
url = 'https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv'
covid = read_csv(url)
head(covid)                                 #check data loaded correctly

#classify data into state/region
region = data.frame(state = state.name, region = state.region)
head(region)

#different ways of 'filtering joins'
###INNER Join
inner_join(covid, region, by = "state") %>%  ##adds region coloumn, ie West, North Central
  count(region)%>%                              ## list of region, and how many for each
  mutate(tot = sum(n))                        ##adds coloumn of total #of regions

##FULL JOIN  (Same as above, but included more NA Values)
full_join(covid, region, by = "state") %>%
  count(region)%>%
  mutate(tot=sum(n))

##LEFT JOIN  ...Produces NA's
left_join(covid, region, by = "state") %>%
  count(region) %>%
  mutate(tot = sum(n))

##RIGHT JOIN
right_join(covid, region, by = "state") %>%
  count(region) %>%
  mutate(tot = sum(n))

##Whats causing NA's
covid %>%
  filter(!state %in% state.name) %>%
  filter(date == max(date)) %>%
  count(state)

covid%>%
  right_join(region, by = "state")%>%  #adds region coloumn to list
  group_by(region, date)%>% #groups by region, date
  summarize(cases  = sum(cases),
            deaths = sum(deaths))%>%   ##coloumn=cases, deaths
  pivot_longer(cols = c('cases', 'deaths'))-> #coloumn=name, value....cases+deaths specified under 'value' for each region by date
covid_region

#PLOTTING
ggplot(covid_region, aes(x = date, y = value))+  #Creates graph, x=date, y=value
  geom_line(aes(col = region))+  #one graph with all data
facet_grid(name~region, scale = "free_y")+ #each region now has own graph for deaths+cases
theme_gray() +
  theme(legend.position = "bottom") +
  theme(legend.position = "NA") +
  labs(title = "Cummulative Cases and Deaths: Region",
       y = "Daily Cumulative Count",
       x = "Date",
       caption = "Daily Exercise 07",
       subtitle = "COVID-19 Data: NY-Times" )
