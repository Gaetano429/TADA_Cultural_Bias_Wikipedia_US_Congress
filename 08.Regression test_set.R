#Regression

model<-glm(party_affiliation~normalised_democrat_score+normalised_republican_score+Sex+length,data = test_set2)
summary(model)

#Confusion Matrix

table_confusion_test = table(test_set2$party_affiliation, test_set2$dictionary_party)

confusion_test_matrix = confusionMatrix(table_confusion_test, mode="everything")

confusion_test_matrix
