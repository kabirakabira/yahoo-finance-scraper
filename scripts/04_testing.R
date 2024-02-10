## test analysis
library(dplyr)
library(data.table)
library(lubridate)

## read in full dataset then filter to 10 groups - we're just testing right now
full.data <- fread('data/processed/Raw_CombinedData.csv') %>%
  group_by(Symbol) %>%
  mutate(new_id = group_indices()) %>%
  filter(new_id <= 10)

## Modify date
full.data <- full.data %>%
  ungroup() %>%
  mutate(
    Year = year(Date),
    Month = month(Date),
    Day = format(Date, "%d"),
    Weekday = weekdays(Date)
  ) 

## Compute Lag by group
full.data <- full.data %>%
  group_by(Symbol) %>%
  mutate(
    Change_1day = Open - lag(Open)
  )