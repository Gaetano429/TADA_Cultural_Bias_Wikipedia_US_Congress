#some graphs..

p <- ggplot(wordscores, aes(x = p_democrats, y = p_republican, color=party_affiliation)) +
  geom_point(size=1.8) + scale_color_manual(values = c("#0015bcff", "#b41e1eff")) +
  theme_minimal() + geom_abline(intercept = 0) + labs(title="Political Bias in Wikipedia Biographies (116th US Congress)",
                                                      subtitle="2.8% of the Wikipedia Biographies are writen in neutral language",
                                                      x="Proportion of Republican words (%)",
                                                      y="Proportion of Democratic words (%)",
                                                      caption="Dictionaries from Goggin (2016)") +theme(plot.subtitle = element_text(color="#666666"), plot.title = element_text(family="Roboto Condensed Bold"),plot.caption = element_text(color="#AAAAAA", size=10)) 
p

library(ggplot2)
ggplot(data=congress_wordscore2, aes(x=congress_wordscore2$democrat_score2, y=congress_wordscore2$republican_score2)) +
  geom_point(size=1.8) + geom_point(aes(color=party_affiliation), alpha=1, shape=18, stroke=1) + 
  labs(title="Dictionary Scores, 116th US Congress biographies",
       subtitle="blue dots are democrats, red dots are republicans",
       x="Democrat dictionary score", 
       y="Republican dictionary score", 
       caption="Dictionaries from Goggin (2016)") +
  scale_color_gradient(low="#b41e1eff", high="#0015bcff") +
  theme_minimal()


ggplot(data=predicted.data, aes(x=rank, y=probability.of.party_affiliation)) +
  geom_point(aes(color=party_affiliation), alpha=1, shape=18, stroke=3) +
  labs(title="   Multivariate Logistic Regression",
       subtitle="",
       x="Democrat wordscore",
       y="Predicted probability of being a Democrat",
       caption="Dictionaries from Goggin (2016)") +
  scale_color_gradient((low="#b41e1eff", high="#0015bcff") +
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

