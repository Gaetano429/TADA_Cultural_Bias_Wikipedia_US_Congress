install.packages("rvest")
install.packages("devtools")
install.packages("tidyverse")
install.packages("WikipediR")
install.packages("WikidataR")
install.packages("jsonlite")
install.packages("future.apply")
install.packages("data.table")
devtools::install_github("saschagobel/legislatoR")
install.packages("quanteda")
install.packages("jsonlite")
install.packages("urltools")
install.packages("xml2")

library(tidyverse)
library(WikipediR)
library(WikidataR)
library(legislatoR)
library(rvest)
library(dplyr)
library(purrr)
library(pb)
library(jsonlite)
library(future.apply)
library(future.apply)
library(tidyverse)
library(urltools)
library(rvest)
library(xml2)

## assign only data for the 12th legislative session into the environment
usa_senate_df <- dplyr::semi_join(x = get_core(legislature = "usa_senate"),
                                  y = dplyr::filter(get_political(legislature = "usa_senate"),
                                                    session == 116),
                                  by = "pageid")

usa_house_df <- dplyr::semi_join(x = get_core(legislature = "usa_house"),
                                 y = dplyr::filter(get_political(legislature = "usa_house"),
                                                   session == 116),
                                 by = "pageid")

#OBTAINING URLS FOR HOUSE AND SENATE
house_url<-paste0("https://en.wikipedia.org/wiki/",usa_house_df$wikititle)
house_url
senate_url<-paste0("https://en.wikipedia.org/wiki/",usa_senate_df$wikititle)
senate_url

#ATTEMPTS AT MERGING LIST
list.url.congress<-list(house_url,senate_url)
list.url.congress<-unlist(list.url.congress)
View(list.url.congress)


#ATTEMPTING TO SCRAPE THE DATA

install.packages("rvest")
library("rvest")
library(dplyr)
library(purrr)
df <- map_df(list.url.congress, function(x){
  webpage <- x %>% read_html()
  
  data.frame(Author = webpage %>%
               html_nodes(xpath = '//*[@id="firstHeading"]') %>% 
               html_text(), #get the name of the person
             Text = webpage %>%
               html_nodes(xpath = '//*[@id="mw-content-text"]/div/p') %>% 
               html_text() %>% #get the content text
               paste0(collapse = "") %>% #collapse the paragraphs
               gsub("\\[\\d{1,3}\\]", "", .) %>% #remove the footnote numbers
               gsub('\n', '', .) %>% #remove "\n" tags
               gsub('\"', '', .) #remove '\"' tags
  )
})
warnings()
View(df)
