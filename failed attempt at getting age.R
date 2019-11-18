get age

## find age
usa_congress_df   birth
install.packages("eeptools")
library(eeptools)
library(data.table)
library(lubridate)





# toy data
X = data.table(usa_congress_df=seq(from=as.Date("1956-04-12"), to=as.Date("1947-12-21"), by="birth"))
Sys.Date()

age_calc(birth, enddate = Sys.Date(), units = "years", precise = TRUE)

yr = duration(num = 1, units = "years")
X[, age := new_interval(birth, Sys.Date())/yr][]

usa_congress_df[death=="NA"]<-2019-11-25
usa_congress_df$Age <- interval(start= usa_congress_df$birth, end=usa_congress_df$death)/                      
  duration(n=1, unit="years")  

usa_congress_df %>% 
  mutate(death = replace(death, death == 'NA', 2019-11-25)
         
         usa_congress_df %>% 
           mutate(10 = as.character(10)) %>% 
           mutate(10 = replace(10, 10 == 'NA', '2019-11-25'))
         
         usa_congress_df$death <- as.character(usa_congress_df$death)
         usa_congress_df$death[usa_congress_df$death == "NA"] <- "2019-11-25"
         usa_congress_df$death <- as.factor(usa_congress_df$death)
         
   
           
           
           