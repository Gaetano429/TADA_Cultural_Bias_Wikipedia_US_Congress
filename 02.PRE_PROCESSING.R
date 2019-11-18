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
