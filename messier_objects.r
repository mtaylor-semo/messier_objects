---
  title: "List of Messier Objects"
  output: pdf_document
---
  
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
## delete last row that repeats column headers, then
## add a blank column to mark whether the object was viewed.
mess_table <- 
  mess_table %>% 
  select(-c(Picture, `Distance (kly)`, `Right Ascension`, Declination)) %>% 
  filter(!`Messier number` == "Messier number") %>% 
  add_column("Viewed" = "")

## Split the Object type into two categories for
## sorting by object rather than Messier number, then
## Remove the Wiki footnotes in brackets after
## the Messier numbers in the first column
mess_table <- mess_table %>% 
  separate(`Object type`,
           into = c('object_type','subtype'), sep = ",", fill = "right") %>%   
  mutate(`Messier number` = str_extract(`Messier number`, "M[0-9]+")) 


