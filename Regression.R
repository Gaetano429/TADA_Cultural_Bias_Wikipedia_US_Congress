#CREATING DUMMY VARIABLE

dummy<-dplyr::pull(congress_wordscore,var = "party_affiliation")
dummy<-as.numeric(party_affiliation == "R")
print(dummy)
congress_wordscore$dummy<-c(dummy)
View(congress_wordscore)

#REGRESSION

linear_dem<-lm(dummy~congress_wordscore$democrat,data=congress_wordscore)
summary(linear_dem)
linear_rep<-lm(dummy~congress_wordscore$republican,data=congress_wordscore)
summary(linear_rep)



