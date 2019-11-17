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

fit = glm(party_affiliation~predicted_party,data = train_wordscore, family=binomial)
newdat <- data.frame(predicted_party=seq(min(train_wordscore$predicted_party), max(train_wordscore$predicted_party),len=100))
newdat$party_affiliation = predict(fit, newdata=newdat, type="response")
plot(party_affiliation~predicted_party,data = train_wordscore, col="red4")
lines(party_affiliation~predicted_party, newdat, col="green4", lwd=2)

#Logistical regression

logreg_control<-glm(party_affiliation~predicted_party+sex,data = train_wordscore)
summary(logreg_control)

contrasts(train_wordscore$sex)

fit = glm(party_affiliation~normalised_democrat_score+normalised_republican_score,data = train_set, family=binomial)
newdat <- data.frame(predicted_party=seq(min(train_wordscore$predicted_party), sex=seq(min(train_wordscore$sex),max(train_wordscore$predicted_party),len=100)))
newdat$party_affiliation = predict(fit, newdata=newdat, type="response")
newdat2<-data.frame(sex=sez(min(train_wordscore$sex),max(train_wordscore$sex),len=100))
newdat2$sex=predict(fit,newdata = newdat2,type="response")
plot(party_affiliation~normalised_democrat_score+normalised_republican_score,data = train_set,data = train_wordscore, col="red4")
lines(party_affiliation~predicted_party, newdat, col="green4", lwd=2)

#Linear regression

linreg<-lm(party_affiliation~predicted_party,data = train_wordscore)
plot(linreg)

(linear_joint <- glm(party_affiliation ~ predicted_party, data=train_wordscore))
contrasts(train_wordscore$predicted_party)
summary.lm(linear_joint)
summary(linear_joint)$adj.r.squared

(linear_joint)
sigma(linear_joint)    # Residual standard error
confint(linear_joint, level = 0.95)

#Logistical regression

congress_wordscore <- attrition %>% mutate_if(is.ordered, factor, ordered = FALSE)
View(congress_wordscore)
