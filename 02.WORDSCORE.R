#CORPUS
library(csv)
library(quanteda)
library(readxl)
corpus<-corpus(df_congress, text_field = "Biography","Politician")
corpus

#CREATING DATAFRAME

congress_tok<-tokens(corpus, what="word",
                        remove_punct = TRUE,
                        remove_symbols = TRUE,
                        remove_numbers = TRUE,
                        remove_twitter = TRUE,
                        remove_url = TRUE,
                        remove_hyphens = FALSE,
                        verbose = TRUE, 
                        include_docvars = TRUE)

congress_tok <- tokens_select(congress_tok, pattern = stopwords('en'), selection = 'remove')
congress_tok <- tokens_tolower(congress_tok)
congress_tok <- tokens(congress_tok, ngrams = c(1:1), include_docvars = TRUE) 
congress_dfm<-dfm(congress_tok)

#GET LENGTH (OF TOKENS) THROUGH XCL
#library(csv)
#my.summary<- summary(congress_tok)
#length_df<-data.frame(ids=length(my.summary), length=my.summary)
#write.csv(length_df, "C:/Users/gaeta/TADA_Cultural_Bias_Wikipedia_US_Congress/length.csv",row.names = FALSE)


length <- read_excel("length.xlsx")
View(length)

df_congress<-dplyr::left_join(x = df_congress,
                               y = length,
                               by = "Politician")
View(df_congress)
#CREATING DICTIONARY FROM GOGGIN READING
library(quanteda)
democrat_dictionary<-dictionary(list(democrat_score = c("government", "psychology", "cornell", "michigan", "american", 
                                                  "georgetown", "yale", "bucknell", "missouri", "mpa", "practice", 
                                                  "private", "center", "community", "health", "development", "adjunct", 
                                                  "court", "services", "high", "senior", "unitarian", "universalist", 
                                                  "african", "disciples", "community", "hindu", "humanist", "muslim", "none", 
                                                  "ucc", "agnostic", "applewood","atheist","believe","beth",
                                                  "brethren","christianity","chair","church",
                                                  "commerce","coalition","education","organization",
                                                  "law","executive","Trustees","institute","union","alumni","development","women" )))
# first dictionary with 52 words
republican_dictionary<-dictionary(list(republican_score =  c("united","academy","illinois","high",
                                                       "technology","pennsylvania","virginia",
                                                       "finance","georgia","vice","office",
                                                       "force","limited","served","medical","corps",
                                                       "liability","navy","group","author",
                                                       "small","presbyterian","assembly",
                                                       "nazarene","reformed","saint","scientist",
                                                       "follower","lds","pentecostal",
                                                       "american","assemblies",
                                                       "cottonwood","east","eastern",
                                                       "eclectic","elca","father","first",
                                                       "foursquare","free","american","commerce", 
                                                       "rifle","rotary","scouts",
                                                       "young","christian","boy","veterans",
                                                       "baptist","coach","life")))
#first rep dicionary with 53 words

#second dictionary for democrats with 50 words
democrat_dictionary2<-dictionary(list(democrat_score2 = c("university","attorney","college","school","director",
                                                          "state","law","science","professor","department",
                                                          "assistant","teacher","international","county",
                                                          "office","harvard","education","phd","staff","private",
                                                          "public","master","psychology","mpa","yale","georgetown",
                                                          "community","center","average","health","senior","board",
                                                          "association","present","women","bar","community",
                                                          "volunteer","alumni","development","institute",
                                                          "new","catholic","roman","jewish","muslim",
                                                          "advisory","city","adjunct")))

#second dictionary for republicans with 50 words
republican_dictionary2<-dictionary(list(republican_score2 =  c("united", "states","present","president",
                                                               "owner","company","army","manager","business",
                                                               "officer","incorporated","air","force","vice",
                                                               "chief","served","small","technology","liability",
                                                               "limited","medical","virginia","mba","author",
                                                               "san","finance","christian","baptist","presbyterian",
                                                               "protestant","jesus","follower","member","former",
                                                               "church","rifle","rotary","boy","veterans","chamber",
                                                               "commerce","foundation","coach","georgia","north",
                                                               "security","great","life")))

#APPLICATION OF DICTIONARIES 

congress_democrat<-dfm_lookup(congress_dfm,democrat_dictionary, valuetype = "fixed")
congress_republican<-dfm_lookup(congress_dfm,republican_dictionary,valuetype = "fixed")
#OR
congress_democrat2<-dfm_lookup(congress_dfm,democrat_dictionary2, valuetype = "fixed")
congress_republican2<-dfm_lookup(congress_dfm,republican_dictionary2,valuetype = "fixed")


congress_wordscore<-merge(congress_democrat,congress_republican, all.x=FALSE)
#OR
congress_wordscore<-merge(congress_democrat2,congress_republican2, all.x=FALSE)


#ordering data alphabetically to make sure the party affiliation will be correctly assigned later on
congress_wordscore <- with(congress_wordscore,  congress_wordscore[order(document),])
View(congress_wordscore)
#ADDING PARTY
congress_wordscore$party_affiliation<-c(usa_congress_df$party)

party_affiliation<-dplyr::pull(congress_wordscore,var = "party_affiliation")
party_affiliation<-as.numeric(party_affiliation == "D")
congress_wordscore$party_affiliation<-c(party_affiliation)

#ADDING DICTIONARY PARTY
#dictionary party - labelling of party depending on wordscore majority
congress_wordscore<- congress_wordscore %>%
  mutate(dictionary_party = if_else(democrat_score2 >= republican_score2, '1', '0'))

congress_wordscore$dictionary_party<-as.numeric(congress_wordscore$dictionary_party)

#ADDING PAGEID
congress_wordscore$pageID<-c(usa_congress_df$pageid)

#ADDING SEX
congress_wordscore$Sex<-c(usa_congress_df$sex)

#ADDING TOTAL EDITORS
congress_wordscore$total_editors<-c(usa_congress_df$total_editors)

#ADDING TOTAL SIZE
congress_wordscore$total_size<-c(usa_congress_df$total_size)

#ADDING ETHNICITY
congress_wordscore$ethnicity<-c(usa_congress_df$ethnicity)

#ADDING RELIGION
congress_wordscore$religion<-c(usa_congress_df$religion)

#ADDING LENGTH
congress_wordscore$length<-c(df_congress$length)

#NORMALISING WORDSCORES BY LENGTH
congress_wordscore$normalised_democrat_score<-c(congress_wordscore$democrat_score2/congress_wordscore$length)
congress_wordscore$normalised_republican_score<-c(congress_wordscore$republican_score2/congress_wordscore$length)
View(congress_wordscore)



