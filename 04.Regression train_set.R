##MODEL 1

#Logistical regression normalised wordscores

model1<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score,data = train_set)
summary(model1)

#logistical regression control variables

model2<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+Sex,data = train_set)
summary(model2)

model3<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+length,data = train_set)
summary(model3)

model4<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+total_editors+total_size,data = train_set)
summary(model4)

model5<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+total_editors+total_size+Sex+length,data = train_set)
summary(model5)

model6<-glm(party_affiliation~dictionary_party+total_editors+total_size+Sex+length,data = train_set)
summary(model6)

model7<-glm(party_affiliation~dictionary_party,data = train_set)
summary(model7)

#MODEL 2

#Logistical regression normalised wordscores

model2.1<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score,data = train_set2)
summary(model2.1)

#logistical regression control variables

model2.2<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+Sex,data = train_set2)
summary(model2.2)

model2.3<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+length,data = train_set2)
summary(model2.3)

model2.4<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+total_editors+total_size,data = train_set2)
summary(model2.4)

model2.5<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+total_editors+total_size+Sex+length,data = train_set2)
summary(model2.5)


