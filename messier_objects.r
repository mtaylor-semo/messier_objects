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

## Remove unneeded columns and
## delete last row that repeats column headers
mess_table <- 
  mess_table %>% 
  select(-c(Picture, `Right Ascension`, Declination)) %>% 
  filter(!`Messier number` == "Messier number")


## Split the Object type into two categories for
## sorting by object rather than Messier number, then
## Remove the Wiki footnotes in brackets after
## the Messier numbers in the first column

mess_table <- mess_table %>% 
  separate(`Object type`,
           into = c('object_type','subtype'), sep = ",") %>% 
  separate(`Messier number`, into = "mess_num", sep = "\\[", extra = "drop")

