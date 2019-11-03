install.packages("rvest")
install.packages("devtools")
install.packages("tidyverse")
install.packages("WikipediR")
install.packages("WikidataR")
install.packages("jsonlite")
install.packages("pbapply")
install.packages("data.table")
devtools::install_github("saschagobel/legislatoR")


library(tidyverse)
library(WikipediR)
library(WikidataR)
library(legislatoR)
library(rvest)
library(dplyr)
library(purrr)

## assign only data for the 12th legislative session into the environment
usa_senate_df <- dplyr::semi_join(x = get_core(legislature = "usa_senate"),
                                  y = dplyr::filter(get_political(legislature = "usa_senate"),
                                                    session == 116),
                                  by = "pageid")

usa_house_df <- dplyr::semi_join(x = get_core(legislature = "usa_house"),
                                 y = dplyr::filter(get_political(legislature = "usa_house"),
                                                   session == 116),
                                 by = "pageid")

house_url<-paste0("https://en.wikipedia.org/wiki/",usa_house_df$wikititle)
senate_url<-paste0("https://en.wikipedia.org/wiki/",usa_senate_df$wikititle)