#CORPUS
library(quanteda)
df_congress_corpus<-corpus(df_congress, text_field = "Biography","Politician")
df_congress_corpus
docvars(df_congress_corpus)
head(docvars(df_congress_corpus))

#CREATING DATAFRAME

congress_df_tok<-tokens(df_congress_corpus, what="word",
                        remove_punct = TRUE,
                        remove_symbols = TRUE,
                        remove_numbers = TRUE,
                        remove_twitter = TRUE,
                        remove_url = TRUE,
                        remove_hyphens = FALSE,
                        verbose = TRUE, 
                        include_docvars = TRUE)

congress_df_tok <- tokens_select(congress_df_tok, pattern = stopwords('en'), selection = 'remove')
congress_df_tok <- tokens_tolower(congress_df_tok)
congress_df_tok <- tokens(congress_df_tok, ngrams = c(1:1), include_docvars = TRUE) 
congress_df_tok
docvars(congress_df_tok) 
congress_dfm<-dfm(congress_df_tok)
docvars(congress_dfm)

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

congress_dfm_democrat<-dfm_lookup(congress_dfm,democrat_dictionary, valuetype = "fixed")
docvars(congress_dfm_democrat)
View(congress_dfm_democrat)
congress_dfm_democrat$party_affiliation<-c(usa_congress_df$party) # try assigning here

congress_dfm_republican<-dfm_lookup(congress_dfm,republican_dictionary,valuetype = "fixed")
docvars(congress_dfm_republican)
View(congress_dfm_republican)
congress_dfm_republican$party_affiliation<-c(usa_congress_df$party) # try assigning here

congress_wordscore<-merge(congress_dfm_democrat,congress_dfm_republican, all.x=FALSE)
# or try merge by x (with x being "document"?)
#congress_wordscore <- dfm_group(congress_dfm_democrat, congress_dfm_republican, groups = "party")
#ndoc(congress_wordscore)

# as.data.frame.dfm is obsolete. integrate  'convert(x, to = "data.frame") 
congress_wordscore$party_affiliation<-c(usa_congress_df$party)
View(congress_wordscore)