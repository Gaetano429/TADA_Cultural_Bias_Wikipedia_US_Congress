#Regression

model<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+Sex+length,data = test_set2)
summary(model)

model_test<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score,data = test_set2, family = "binomial")
summary(model_test)

#The intercept is the log(odds) a predicted Republican will be a Democrat. 

#Normalised_democrat_score is the log(odds ratio) that tells us that if a politician is predicted Democrat the odds
#of being democrat are, on a log scale, 38.64 times greater than if a politician was predicted Republican.

#Normalised_republican_score, is the log odds ration that tells tells us that if a politician is predicted Republican,
#the odds of being democrat are, on a log scale 15.1690 times lesser than if a politician was predicted Democrat.

model_test2<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+total_editors+total_size+Sex+length,data = test_set2)
summary(model_test2)


## Now calculate the overall "Pseudo R-squared" and its p-value

ll.null <- model_test2$null.deviance/-2
ll.proposed <- model_test2$deviance/-2

## McFadden's Pseudo R^2 = [ LL(Null) - LL(Proposed) ] / LL(Null)
(ll.null - ll.proposed) / ll.null
#Our McFadden's PseudoR^2 is 0.2158927

## chi-square value = 2*(LL(Proposed) - LL(Null))
## p-value = 1 - pchisq(chi-square value, df = 2-1)
1 - pchisq(2*(ll.proposed - ll.null), df=(length(model_test2$coefficients)-1))

## logistic regression prediction
predicted.data <- data.frame(
  probability.of.party_affiliation=model_test2$fitted.values,
  party_affiliation=test_set2$party_affiliation)

#Plot

predicted.data <- predicted.data[
  order(predicted.data$probability.of.party_affiliation, decreasing=FALSE),]
predicted.data$rank <- 1:nrow(predicted.data)


## Predicted probabilities for each sample of being Democrat and color by whether or not they actually
## are democrat
ggplot(data=predicted.data, aes(x=rank, y=probability.of.party_affiliation)) +
  geom_point(aes(color=party_affiliation), alpha=1, shape=4, stroke=2) +
  xlab("Index") +
  ylab("Predicted probability of being a Democrat")

ggsave("democrat_probabilities.pdf")


#Confusion Matrix

table_confusion_test = table(test_set2$party_affiliation, test_set2$dictionary_party)

confusion_test_matrix = confusionMatrix(table_confusion_test, mode="everything")

confusion_test_matrix
