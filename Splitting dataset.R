#DIVIDING DATA IN TRAINING AND TEST SET

df_congress$id <- 1:nrow(df_congress)
train <- df_congress %>% dplyr::sample_frac(.75)
test  <- dplyr::anti_join(df_congress, train, by = 'id')
View(train)

#ORDERING DATA ALPHABETICALLY
train <- with(train,train[order(Politician),])
View(train)

