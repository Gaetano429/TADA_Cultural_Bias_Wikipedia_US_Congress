install.packages("devtools")
install.packages("readtext")
install.packages("quanteda")
install.packages("Rcpp")
install.packages("dplyr")
install.packages("tidyverse")
install.packages("tm")

library(tidyverse)
library(readtext)
library(dplyr)
library(quanteda)
#data for dems
DATA_DIR <- system.file("extdata/", package = "readtext")
us_democrats <- readtext(paste0(DATA_DIR, "/txt/Bio_Democrats/*.txt"),
                         docvarsfrom = "filenames",
                         dvsep="_",
                         docvarnames = c("Party", "ID", "Name"))
us_democrats$doc_id <- str_replace(us_democrats$doc_id , ".txt", "") %>%
  str_replace(. , "_\\d{2}", "")
#data for republicans
DATA_DIR <- system.file("extdata/", package = "readtext")
us_republicans <- readtext(paste0(DATA_DIR, "/txt/Bio_Republicans/*.txt"),
                         docvarsfrom = "filenames",
                         dvsep="_",
                         docvarnames = c("Party", "ID", "Name"))
us_republicans$doc_id <- str_replace(us_republicans$doc_id , ".txt", "") %>%
  str_replace(. , "_\\d{2}", "")

#Data for congress
DATA_DIR <- system.file("extdata/", package = "readtext")
us_congress <- readtext(paste0(DATA_DIR, "/txt/Bio_Congress/*.txt"),
                    docvarsfrom = "filenames",
                    dvsep="_",
                    docvarnames = c("Party", "ID", "Name"))
us_congress$doc_id <- str_replace(us_congress$doc_id , ".txt", "") %>%
  str_replace(. , "_\\d{2}", "")


#create corpus
democrat_corpus <- corpus(us_democrats, text_field ="text")
republican_corpus <- corpus(us_republicans, text_field ="text")
congress_corpus <- corpus(us_congress, text_field ="text")
summary(democrat_corpus)
summary(republican_corpus)
summary(congress_corpus) 
congress_summary <- summarise(group_by(summary(congress_corpus, n = 44),Party),
                              n(),sum(Sentences),sum(Tokens))
#tokenising congress
Congress_tok <- tokens(congress_corpus, what = "word",
                       remove_punct = TRUE,
                       remove_symbols = TRUE,
                       remove_numbers = TRUE,
                       remove_twitter = TRUE,
                       remove_url = TRUE,
                       remove_hyphens = FALSE,
                       verbose = TRUE,
                       include_docvars = TRUE)
Congress_tok <- tokens_select(Congress_tok, pattern = stopwords('en'), selection = 'remove')
Congress_tok <- tokens_tolower(Congress_tok)
Congress_tok <- tokens(Congress_tok, ngrams = c(1:1), include_docvars = TRUE) 
Congress_tok
#dfm congress
dfm_congress<-dfm(Congress_tok)
topfeatures(dfm_congress,200)


#tokenising democrats
democrat_tok <- tokens(democrat_corpus, what = "word",
                       remove_punct = TRUE,
                       remove_symbols = TRUE,
                       remove_numbers = TRUE,
                       remove_twitter = TRUE,
                       remove_url = TRUE,
                       remove_hyphens = FALSE,
                       verbose = TRUE,
                       include_docvars = TRUE)
democrat_tok <- tokens_select(democrat_tok, pattern = stopwords('en'), selection = 'remove')
democrat_tok <- tokens_tolower(democrat_tok)
democrat_tok <- tokens(democrat_tok, ngrams = c(1:1), include_docvars = TRUE) 
democrat_tok
#dfm dem
dfm_democrat<-dfm(democrat_tok)
topfeatures(dfm_democrat,200)



#tokenising republicans
republican_tok <- tokens(republican_corpus, what = "word",
                       remove_punct = TRUE,
                       remove_symbols = TRUE,
                       remove_numbers = TRUE,
                       remove_twitter = TRUE,
                       remove_url = TRUE,
                       remove_hyphens = FALSE,
                       verbose = TRUE,
                       include_docvars = TRUE)
republican_tok <- tokens_select(republican_tok, pattern = stopwords('en'), selection = 'remove')
republican_tok <- tokens_tolower(republican_tok)
republican_tok <- tokens(republican_tok, ngrams = c(1:1), include_docvars = TRUE) 
republican_tok
#dfm congress
dfm_republican<-dfm(republican_tok)
topfeatures(dfm_republican,200)
                      
##########


#Creating the dictionary object of Republicans and Democrats
#from Goggin reading
democrat_dictionary<-dictionary(list(democrat = c("government","psychology","cornell",
                                                  "michigan","american","georgetown",
                                                  "yale","bucknell","missouri","mpa",
                                                  "practice","private","center","community", 
                                                  "health","development","adjunct","court",
                                                  "services","high","senior","unitarian",
                                                  "universalist","african","disciples",
                                                  "community","hindu","humanist","muslim",
                                                  "none","ucc","humanist","agnostic","applewood",
                                                  "atheist","believe","beth","brethren",
                                                  "christianity","christianity","chair",
                                                  "church","commerce","coalition","democratic",
                                                  "education","organization","law","executive",
                                                  "Trustees","institute","union","alumni",
                                                  "development","women")))


republican_dictionary<-dictionary(list(republican = c("united","academy","illinois","high",
                                                      "technology","pennsylvania","virginia",
                                                      "finance","georgia","vice","office",
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

#Look up Republican and Democrat term counts on whole corpus
dfm_congress
democrat_language_dfm<-dfm_lookup(dfm_congress,democrat_dictionary,valuetype = "fixed")
republican_language_dfm<-dfm_lookup(dfm_congress,republican_dictionary,valuetype = "fixed")
republican_language_dfm


#applying the two dictionaries at once to all.
#congress_language_dfm<-dfm_lookup(dfm_congress, democrat_dictionary, republican_dictionary, valuetype = "fixed")

#Democrat dictionary applied to Democrats
Democrat_democrat_language_dfm<-dfm_lookup(dfm_democrat,democrat_dictionary,valuetype = "fixed")
#Republican dictionary applied to Democrats
Democrat_republican_language_dfm<-dfm_lookup(dfm_democrat,republican_dictionary,valuetype = "fixed")


#Republican dictionary applied to Republicans
Republican_republican_language_dfm<-dfm_lookup(dfm_republican,republican_dictionary,valuetype = "fixed")
#Democrat dictionary applied to Republicans
Republican_democrate_language_dfm<-dfm_lookup(dfm_republican,democrat_dictionary,valuetype = "fixed")


dem_dem <- convert(Democrat_democrat_language_dfm, to = "data.frame")
dem_rep <- convert(Democrat_republican_language_dfm, to = "data.frame")
sum(dem_dem, dem_rep)
rep_rep <- convert(Republican_republican_language_dfm, to = "data.frame")
rep_dem <- convert(Republican_democrate_language_dfm, to = "data.frame")
sum(rep_dem, rep_dem)


#merge
names(rep_rep)[1] <- "names"
names(rep_dem)[1]<-"names"
view(rep_rep)
view(rep_dem)
REP<-merge(rep_rep,rep_dem, by = "names")
REP

names(dem_dem)[1] <- "names"
names(dem_rep)[1]<-"names"
view(dem_dem)
view(dem_rep)
DEM<-merge(dem_dem,dem_rep, by = "names")
DEM

#textplot
textplot_wordcloud(dfm_democrat) 

textplot_wordcloud(dfm_republican)
                   
                   

# you have the data. you can add another collumn, with a label you're trying to predict; 
#whether the person is a dem or rep (0 ; 1).
#it will try to predict based DR DM. predict binary outcome. a logistical regression. 
#control variable, gendr, length, drop the independent MPs if necessary.  
# predict through dictionnary if someone is republican or democrat. you need a statistical model. 
#allows us to test if its tangible.
# relearn how to do a reg 
# update ditionary, you can populate your dictionary. 

# control variables. something readily available,not something you have to spend alot of time on. 
#whether Trump won. democrats in trump states try to be purple democrats.


textmodel_wordscores()

# training Naive Bayes model
nb <- textmodel_nb(dfm_congress[congress_corpus,],

# predicting labels for test set
preds <- predict(nb, newdata = dfm_congress[congress_corpus,])

# computing the confusion matrix
(cm <- table(preds,[congress_corpus,]))

#text probability


# extracting posterior word probabilities
probs <- nb$PcGw
probs <- 55$
probs[,c("government","psychology","cornell",
"michigan","american","georgetown",
"yale","bucknell","missouri","mpa",
"practice","private","center","community", 
"health","development","adjunct","court",
"services","high","senior","unitarian",
"universalist","african","disciples",
"community","hindu","humanist","muslim",
"none","ucc","humanist","agnostic","applewood",
"atheist","believe","beth","brethren",
"christianity","christianity","chair",
"church","commerce","coalition","democratic",
"education","organization","law","executive",
"Trustees","institute","union","alumni",
"development","women")]


# and this is how we would extract the features with the highest and lowest posterior class probabilities
df <- data.frame(
  ngram = colnames(probs),
  prob_female_ngram = probs["female",],
  stringsAsFactors=F)
df <- df[order(df$prob_female_ngram),]

head(df, n=10)
tail(df, n=10)
```

"Probability of '{}': {}".format(w,words[w]/sumWords
                                 
                                 
sample = list(Congress_tok(tokens))[:10]
sample
[u'united',u'academy',u'illinois',u'high',
  u'technology',u'pennsylvania',u'virginia',
  u'finance',u'georgia',u'vice",u'office',
  u'force',u'limited',u'served",u'medical",u'corps",
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
"baptist","coach","life"]

tallyLoop = []
for word in sample: tallyLoop.append(text.count(word))
...
tallyLoop
[13, 1, 1, 1, 1, 1, 1, 1, 1, 1]
tallyLC = [tokens.count(word) for word in sample]
tallyLC                   
                   
                   
                   
