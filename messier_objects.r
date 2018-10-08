library(rvest)
library(tidyverse)

## Get the Wikipedia page
messier <- read_html("https://en.wikipedia.org/wiki/List_of_Messier_objects")


## The .[[1]] selects the first table in the list,
## which is the table of interest.
mess_table <-
  messier %>%
  html_nodes("table") %>%
  html_table(fill = TRUE) %>%
  .[[1]]

## Remove unneeded columns
mess_table <- 
  mess_table %>% 
  select(-c(Picture, `Right Ascension`, Declination))

## Delete last row, which repeats column headers
mess_table <- mess_table %>% 
  filter(!`Messier number` == "Messier number")
