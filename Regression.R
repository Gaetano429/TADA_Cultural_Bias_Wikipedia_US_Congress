#CREATING DUMMY VARIABLE
install.packages("vip") 
library(dplyr)     # for data wrangling
library(ggplot2)   # for awesome plotting
library(rsample)   # for data splitting
library(caret)     # for logistic regression modeling
library(vip)       # variable importance

# using our files congress_wordscore

party_affiliation<-dplyr::pull(congress_wordscore,var = "party_affiliation")
party_affiliation<-as.numeric(party_affiliation == "R")
print(party_affiliation)
congress_wordscore$party_affiliation<-c(party_affiliation)
View(congress_wordscore)


#REGRESSION


(linear_joint <- lm(party_affiliation ~ democrat + republican, data=congress_wordscore))
NA

summary(linear_joint)coefficients[1:1]
summary(linear_joint)$adj.r.squared
summary((linear_joint)$




