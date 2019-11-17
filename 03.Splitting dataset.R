#DIVIDING DATA IN TRAINING AND TEST SET

congress_wordscore$id <- 1:nrow(congress_wordscore)
train_set <- congress_wordscore %>% dplyr::sample_frac(.75)
test_set  <- dplyr::anti_join(congress_wordscore, train_set, by = 'id')

#ORDERING DATA ALPHABETICALLY
train_set <- with(train_set,train_set[order(document),])
test_set <- with(test_set,test_set[order(document),])
 
