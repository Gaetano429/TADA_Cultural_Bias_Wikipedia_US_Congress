#CREATING DUMMY VARIABLE

library(dplyr)     # for data wrangling
library(ggplot2)   # for awesome plotting
library(rsample)   # for data splitting
library(caret)     # for logistic regression modeling
library(vip)       # variable importance

# using our files congress_wordscore

party_affiliation<-dplyr::pull(congress_wordscore,var = "party_affiliation")
party_affiliation<-as.numeric(party_affiliation == "R")
print(party_affiliation)
congress_wordscore$party_affiliation<-c(party_affiliation)
View(congress_wordscore)


#linear REGRESSION


(linear_joint <- lm(party_affiliation ~ democrat + republican, data=congress_wordscore))
summary.lm(linear_joint)
summary(linear_joint)$adj.r.squared

sigma(linear_joint)    # Residual standard error
confint(linear_joint, level = 0.95)

#Logistical regression

congress_wordscore <- attrition %>% mutate_if(is.ordered, factor, ordered = FALSE)
View(congress_wordscore)

# Create training (70%) and test (30%) sets for the 
# rsample::attrition data.
set.seed(123)  # for reproducibility
churn_split <- initial_split(df, prop = .7, strata = "Attrition")
churn_train <- training(churn_split)
churn_test  <- testing(churn_split)


model1 <- glm(Attrition ~ democrat, family = "binomial", data = churn_train)
model2 <- glm(Attrition ~ republican, family = "binomial", data = churn_train)

tidy(model1)
tidy(model2)
confint(model1)
confint(model2)

model3 <- glm(
  Attrition ~ democrat + republican,
  family = "binomial", 
  data = churn_train
)
tidy(model3)