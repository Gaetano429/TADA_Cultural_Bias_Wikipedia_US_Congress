#MODEL 1 (use only if running dictionary 1)
#DIVIDING DATA IN TRAINING AND TEST SET

congress_wordscore$id <- 1:nrow(congress_wordscore)
train_set <- congress_wordscore %>% dplyr::sample_frac(.75)
test_set  <- dplyr::anti_join(congress_wordscore, train_set, by = 'id')

#ORDERING DATA ALPHABETICALLY
train_set <- with(train_set,train_set[order(document),])
test_set <- with(test_set,test_set[order(document),])

write_csv(train_set,"/Users/ulyssedemonio/Desktop/train_set.csv")
write_csv(test_set,"/Users/ulyssedemonio/Desktop/test_set.csv")

#MODEL 2 (use only if running dictionary 2)
#DIVIDING DATA IN TRAINING AND TEST SET

congress_wordscore2$id <- 1:nrow(congress_wordscore2)
train_set2 <- congress_wordscore2 %>% dplyr::sample_frac(.75)
test_set2  <- dplyr::anti_join(congress_wordscore2, train_set, by = 'id')

#ORDERING DATA ALPHABETICALLY
train_set2 <- with(train_set2,train_set2[order(document),])
test_set2 <- with(test_set2,test_set2[order(document),])
view(train_set2)
