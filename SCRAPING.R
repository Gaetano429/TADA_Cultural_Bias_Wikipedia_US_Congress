install.packages("devtools")
devtools::install_github("saschagobel/legislatoR")
install.packages("quanteda")
install.packages("rvest")
install.packages("tidyverse")
install.packages("WikipediR")
install.packages("WikidataR")

library(tidyverse)
library(WikipediR)
library(WikidataR)
library(legislatoR)
library(rvest)

#MYCODE
#USA SENATE


usa_senate_df_dem <- dplyr::semi_join(x = get_core(legislature = "usa_senate"),
                                      y = dplyr::filter(get_political(legislature = "usa_senate"), party=="D",
                                                        session == 116),
                                      by = "pageid")

usa_senate_df_rep <- dplyr::semi_join(x = get_core(legislature = "usa_senate"),
                                      y = dplyr::filter(get_political(legislature = "usa_senate"), party=="R", 
                                                        session == 116),
                                      by = "pageid")

usa_senate_df_dem$party<-c("D")        
usa_senate_df_rep$party<-c("R")

usa_senate_df<-dplyr::bind_rows(usa_senate_df_dem,usa_senate_df_rep)
usa_senate_df<- dplyr::left_join(x = usa_senate_df,
                                 y = get_history(legislature = "usa_senate"), session == 116,
                                 by = "pageid")

write.xlsx(data,"C:/Users/FGM/Dropbox/00 MPP Hertie School/03 Third Semester/02 Text as Data/length.xlsx")
install.packages("xlsx")
library(xlsx)
write.xlsx(usa_senate_df,"C:/Users/gaeta/Documents/R/senator.xlsx")



#USA HOUSE
usa_house_df_dem <- dplyr::semi_join(x = get_core(legislature = "usa_house"),
                                     y = dplyr::filter(get_political(legislature = "usa_house"), party=="D",
                                                       session == 116),
                                     by = "pageid")



usa_house_df_rep <- dplyr::semi_join(x = get_core(legislature = "usa_house"),
                                     y = dplyr::filter(get_political(legislature = "usa_house"), party=="R",
                                                       session == 116),
                                     by = "pageid")

usa_house_df_dem$party<-c("D")
usa_house_df_rep$party<-c("R")

usa_house_df<-dplyr::bind_rows(usa_house_df_dem,usa_house_df_rep)
usa_house_df<- dplyr::left_join(x = usa_house_df,
                                 y = get_history(legislature = "usa_house"), session == 116,
                                 by = "pageid")

#CREATION OF CONGRESS DATA FRAME(S)
usa_congress_df<-merge(usa_house_df,usa_senate_df, all.x = TRUE, all.y = TRUE)
#ordering data alphabetically to make sure the party affiliation will be correctly assigned later on
usa_congress_df <- with(usa_congress_df,  usa_congress_df[order(wikititle) , ])

#OBTAINING URLS
congress_url <- paste0("https://en.wikipedia.org/wiki/",usa_congress_df$wikititle)
urls<-c(congress_url)
usa_congress_df$urls<-urls
View(usa_congress_df)


#SCRAPING
library(rvest)
library(dplyr)
library(purrr)

df_congress <- map_df(urls, function(x){
  webpage <- x %>% read_html()
  
  data.frame(Politician = webpage %>%
               html_nodes(xpath = '//*[@id="firstHeading"]') %>% 
               html_text(), #get the name of the person
             Biography = webpage %>%
               html_nodes(xpath = '//*[@id="mw-content-text"]/div/p') %>% 
               html_text() %>% #get the content text
               paste0(collapse = "") %>% #collapse the paragraphs
               gsub("\\[\\d{1,3}\\]", "", .) %>% #remove the footnote numbers
               gsub('\n', '', .) %>% #remove "\n" tags
               gsub('\"', '', .) #remove '\"' tags 
  )
})
warnings(50)



#ADDING PARTY
df_congress$Party<-c(usa_congress_df$party)
df_congress$pageID<-c(usa_congress_df$pageid)
View(df_congress)
