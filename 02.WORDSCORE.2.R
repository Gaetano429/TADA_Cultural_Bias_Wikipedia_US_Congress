#CREATING SECOND DICTIONARY FROM GOGGIN READING

library(quanteda)
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

congress_democrat2<-dfm_lookup(congress_dfm,democrat_dictionary2, valuetype = "fixed")
congress_republican2<-dfm_lookup(congress_dfm,republican_dictionary2,valuetype = "fixed")

congress_wordscore2<-merge(congress_democrat2,congress_republican2, all.x=FALSE)


#ordering data alphabetically to make sure the party affiliation will be correctly assigned later on
congress_wordscore2 <- with(congress_wordscore2,  congress_wordscore2[order(document),])

#ADDING PARTY
congress_wordscore2$party_affiliation<-c(usa_congress_df$party)

party_affiliation<-dplyr::pull(congress_wordscore2,var = "party_affiliation")
party_affiliation<-as.numeric(party_affiliation == "D")
congress_wordscore2$party_affiliation<-c(party_affiliation)

#ADDING DICTIONARY PARTY
#dictionary party - labelling of party depending on wordscore majority
congress_wordscore2<- congress_wordscore2 %>%
  mutate(dictionary_party = if_else(democrat_score2 >= republican_score2, '1', '0'))

congress_wordscore2$dictionary_party<-as.numeric(congress_wordscore2$dictionary_party)

#ADDING PAGEID
congress_wordscore2$pageID<-c(usa_congress_df$pageid)

#ADDING SEX
congress_wordscore2$Sex<-c(usa_congress_df$sex)

#ADDING TOTAL EDITORS
congress_wordscore2$total_editors<-c(usa_congress_df$total_editors)

#ADDING TOTAL SIZE
congress_wordscore2$total_size<-c(usa_congress_df$total_size)

#ADDING ETHNICITY
congress_wordscore2$ethnicity<-c(usa_congress_df$ethnicity)

#ADDING RELIGION
congress_wordscore2$religion<-c(usa_congress_df$religion)

#ADDING LENGTH
congress_wordscore2$length<-c(df_congress$length)

#NORMALISING WORDSCORES BY LENGTH
congress_wordscore2$normalised_democrat_score<-c(congress_wordscore2$democrat_score2/congress_wordscore2$length)
congress_wordscore2$normalised_republican_score<-c(congress_wordscore2$republican_score2/congress_wordscore2$length)
View(congress_wordscore2)

