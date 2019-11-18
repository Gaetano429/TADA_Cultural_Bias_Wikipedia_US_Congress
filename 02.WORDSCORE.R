#CREATING FIRST DICTIONARY FROM GOGGIN READING 
library(quanteda)
# first dictionary with 52 words
democrat_dictionary<-dictionary(list(democrat_score = c("government", "psychology", "cornell", "michigan", "american", 
                                                  "georgetown", "yale", "bucknell", "missouri", "mpa", "practice", 
                                                  "private", "center", "community", "health", "development", "adjunct", 
                                                  "court", "services", "high", "senior", "unitarian", "universalist", 
                                                  "african", "disciples", "community", "hindu", "humanist", "muslim", "none", 
                                                  "ucc", "agnostic", "applewood","atheist","believe","beth",
                                                  "brethren","christianity","chair","church",
                                                  "commerce","coalition","education","organization",
                                                  "law","executive","Trustees","institute","union","alumni","development","women" )))
#first rep dicionary with 53 words
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

#APPLICATION OF DICTIONARIES 

congress_democrat<-dfm_lookup(congress_dfm,democrat_dictionary, valuetype = "fixed")
congress_republican<-dfm_lookup(congress_dfm,republican_dictionary,valuetype = "fixed")


congress_wordscore<-merge(congress_democrat,congress_republican, all.x=FALSE)


#ordering data alphabetically to make sure the party affiliation will be correctly assigned later on
congress_wordscore <- with(congress_wordscore,  congress_wordscore[order(document),])

#ADDING PARTY
congress_wordscore$party_affiliation<-c(usa_congress_df$party)

party_affiliation<-dplyr::pull(congress_wordscore,var = "party_affiliation")
party_affiliation<-as.numeric(party_affiliation == "D")
congress_wordscore$party_affiliation<-c(party_affiliation)

#ADDING DICTIONARY PARTY
#dictionary party - labelling of party depending on wordscore majority
congress_wordscore<- congress_wordscore %>%
  mutate(dictionary_party = if_else(democrat_score >= republican_score, '1', '0'))

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
congress_wordscore$normalised_democrat_score<-c(congress_wordscore$democrat_score/congress_wordscore$length)
congress_wordscore$normalised_republican_score<-c(congress_wordscore$republican_score/congress_wordscore$length)
View(congress_wordscore)



