#CORPUS
library(quanteda)
train_corpus<-corpus(train, text_field = "Biography","Politician")
train_corpus
docvars(train_corpus)

#CREATING DATAFRAME

train_tok<-tokens(train_corpus, what="word",
                        remove_punct = TRUE,
                        remove_symbols = TRUE,
                        remove_numbers = TRUE,
                        remove_twitter = TRUE,
                        remove_url = TRUE,
                        remove_hyphens = FALSE,
                        verbose = TRUE, 
                        include_docvars = TRUE)

train_tok <- tokens_select(congress_df_tok, pattern = stopwords('en'), selection = 'remove')
train_tok <- tokens_tolower(congress_df_tok)
train_tok <- tokens(congress_df_tok, ngrams = c(1:1), include_docvars = TRUE) 
train_tok
docvars(train_tok) 
train_dfm<-dfm(train_tok)
docvars(train_dfm)


#CREATING DICTIONARY FROM GOGGIN READING
library(quanteda)
democrat_dictionary<-dictionary(list(democrat = c("government", "psychology", "cornell", "michigan", "american", 
                                                  "georgetown", "yale", "bucknell", "missouri", "mpa", "practice", 
                                                  "private", "center", "community", "health", "development", "adjunct", 
                                                  "court", "services", "high", "senior", "unitarian", "universalist", 
                                                  "african", "disciples", "community", "hindu", "humanist", "muslim", "none", 
                                                  "ucc", "agnostic", "applewood","atheist","believe","beth",
                                                  "brethren","christianity","chair","church",
                                                  "commerce","coalition","democratic","education","organization",
                                                  "law","executive","Trustees","institute","union","alumni","development","women" )))
republican_dictionary<-dictionary(list(republican =  c("united","academy","illinois","high",
                                                       "technology","pennsylvania","virginia",
                                                       "finance","georgia","vice","vice","office",
                                                       "force","limited","served","medical","corps",
                                                       "liability","navy","group","author",
                                                       "small","presbyterian","assembly",
                                                       "nazarene","reformed","saint","scientist",
                                                       "follower","lds","pentecostal",
                                                       "amercian","assemblies",
                                                       "cottonwood","east","eastern",
                                                       "eclectic","elca","father","first",
                                                       "foursquare","free","american","commerce", 
                                                       "republican","rifle","rotary","scouts",
                                                       "young","christian","boy","veterans",
                                                       "baptist","coach","life")))

#APPLICATION OF DICTIONARIES 

train_democrat<-dfm_lookup(train_dfm,democrat_dictionary, valuetype = "fixed")
docvars(train_democrat)

train_republican<-dfm_lookup(train_dfm,republican_dictionary,valuetype = "fixed")
docvars(congress_dfm_republican)


train_wordscore<-merge(train_democrat,train_republican, all.x=FALSE)
View(train_wordscore)
#reassigning party 
train_wordscore$party_affiliation<-c(usa_congress_df$party)
View(train_wordscore)
#predicted party
predicted.affiliated<- train_wordscore %>%
  mutate(predicted_party = if_else(democrat >= republican, '1', '0'))
