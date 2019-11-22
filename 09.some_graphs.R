#some graphs..


library(ggplot2)
ggplot(data=congress_wordscore2, aes(x=congress_wordscore2$democrat_score2, y=congress_wordscore2$republican_score2)) +
  geom_point(size=1.8) + geom_point(aes(color=party_affiliation), alpha=1, shape=18, stroke=1) + 
  labs(title="Dictionary Scores, 116th US Congress biographies",
       subtitle="light blue crosses are democrats, dark blue crosses are republicans",
       x="Democrat dictionary score", 
       y="Republican dictionary score", 
       caption="Dictionaries from Goggin (2016)") +
  scale_color_gradient(low="#0015bcff", high="#b41e1eff") +
  theme_minimal()


ggplot(data=predicted.data, aes(x=rank, y=probability.of.party_affiliation)) +
  geom_point(aes(color=party_affiliation), alpha=1, shape=18, stroke=3) +
  labs(title="   Multivariate Logistic Regression",
       subtitle="wtf",
       x="Democrat wordscore",
       y="Predicted probability of being a Democrat",
       caption="Dictionaries from Goggin (2016)") +
  scale_color_gradient(low="#0015bcff", high="#b41e1eff") +
  theme_minimal()


#Simple Scatterplot



plot(congress_wordscore2$length,congress_wordscore2$democrat_score2, main="Scatterplot length/democratscore2",
     xlab="length", ylab="dem score")
lines(lowess(congress_wordscore2$length,congress_wordscore2$democrat_score2), col="blue") 

plot(congress_wordscore2$length,congress_wordscore2$republican_score2, main="Scatterplot length/republicanscore2",
     xlab="length", ylab="rep score")
lines(lowess(congress_wordscore2$length,congress_wordscore2$republican_score2), col="red") 

plot(congress_wordscore2$total_editors, congress_wordscore2$democrat_score2, main="Scatterplot editors/demscore2",
     xlab="editors", ylab="dem score")
lines(lowess(congress_wordscore2$total_editors,congress_wordscore2$democrat_score2), col="blue") 

plot(congress_wordscore2$total_editors, congress_wordscore2$republican_score2, main="Scatterplot editors rep score",
     xlab="editors", ylab="rep score")
lines(lowess(congress_wordscore2$total_editors,congress_wordscore2$republican_score2), col="red") 

