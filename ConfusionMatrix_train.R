install.packages("caret")
install.packages("e1071")
library(caret) 
library(e1071)

#MODEL 1

table_confusion = table(train_set$party_affiliation, train_set$dictionary_party)
                        
confusion_matrix = confusionMatrix(table_confusion, mode="everything")

confusion_matrix
print(confusion_matrix)

#MODEL 2

table_confusion2 = table(train_set2$party_affiliation, train_set2$dictionary_party)

confusion_matrix2 = confusionMatrix(table_confusion, mode="everything")

confusion_matrix2
