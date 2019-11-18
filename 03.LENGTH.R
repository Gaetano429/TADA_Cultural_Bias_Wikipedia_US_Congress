#GET LENGTH (OF TOKENS) THROUGH XCL

library(csv)
#do not run if file already downloaded from git
my.summary<- summary(congress_tok)
length_df<-data.frame(ids=length(my.summary), length=my.summary)
write.csv(length_df, "C:/Users/gaeta/TADA_Cultural_Bias_Wikipedia_US_Congress/length.csv",row.names = FALSE)


length <- read_excel("length.xlsx")


#join the length to the data frame

df_congress<-dplyr::left_join(x = df_congress,
                              y = length,
                              by = "Politician")