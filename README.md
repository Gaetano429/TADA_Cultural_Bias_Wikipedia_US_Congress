# TADA_Cultural_Bias_Wikipedia_US_Congress
Hertie School TADA project, analysing potential bias on wikipedia bios of US congressmen and women. 




analysing bias in the biographies of american senators and representatives, This is using sing the legislatoR package of Simon Munzert and Sascha Gobel https://github.com/saschagobel/legislatoR

01.SCRAPING.R allows you to create a Data frame, to then scrap all the wikipedia biographies and then bind them again.

02.PRE_PROCESSING.R tokenizes and removes stopwords to finally create a dfm

03.LENGTH.R downloads the length of the tokenized (pre-processed texts)

04.WORDSCORE.R and 04.WORDSCORE.2.R are the two different dictionaries and their respective wordscore applications.

05.Splitting dataset.R splits the data between a train and a test set.

06.Regression train_set.R experimenting with different regression models and dictionaries

07.ConfusionMatrix_train.R evaluation of the overall model using training set.

08.Regression test_set.R application of our best model to the test_set.

Midterm_report.R code for preliminary submission.

senate_history.xlsx and house_history.xlsx are the data collected with legislator in 01.SCRAPING.R, then manipulated in excell. ibid for length.xlsx

failed attempt at getting age.R is an unsuccesful attempt to transform DOB into age
