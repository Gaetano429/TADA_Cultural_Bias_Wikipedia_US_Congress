#some graphs..


library(ggplot2)
ggplot(data=congress_wordscore2, aes(x=congress_wordscore2$democrat_score2, y=congress_wordscore2$republican_score2)) +
  geom_point(aes(color=party_affiliation), alpha=1, shape=4, stroke=2) +
  xlab("Democrat score") +
  ylab("Republic score")


#Simple Scatterplot



plot(congress_wordscore2$length,congress_wordscore2$democrat_score2, main="Scatterplot length/democratscore2",
     xlab="length", ylab="dem score")
lines(lowess(congress_wordscore2$length,congress_wordscore2$democrat_score2), col="blue") 

plot(congress_wordscore2$length,congress_wordscore2$republican_score2, main="Scatterplot length/republicanscore2",
     xlab="length", ylab="rep score")
lines(lowess(congress_wordscore2$length,congress_wordscore2$republican_score2), col="red") 

plot(congress_wordscore2$total_editors, congress_wordscore2$democrat_score2, main="Scatterplot editors/dem_score2",
     xlab="editors", ylab="dem score")
lines(lowess(congress_wordscore2$total_editors,congress_wordscore2$democrat_score2), col="blue") 

plot(congress_wordscore2$total_editors, congress_wordscore2$republican_score2, main="Scatterplot editors rep score",
     xlab="editors", ylab="rep score")
lines(lowess(congress_wordscore2$total_editors,congress_wordscore2$republican_score2), col="red") 

