library(tidyverse)


data <- read.csv("heart.csv")
data


head(data)

tail(data)

glimpse(data)


ncol(data)

nrow(data)

colnames(data)

summary(data)

## Data Transformations

data2 <- data %>%
  mutate(sex = if_else(sex ==1,"Male","Female"),
         fbs = if_else(fbs==1,">120","<120"),
         exang = if_else(exang ==1,"YES","NO"),
         cp = if_else(cp==1,"ATYPICAL ANGINA",
                      if_else(cp == 2,"NON-ANGINAL PAIN","ASYMPTOMATIC")),
         restecg = if_else(restecg == 0,"NORMAL",
                           if_else(restecg == 1,"ABNORMALITY","PROBABLE OR DEFINITE")),
         slope=as.factor(slope),
         ca = as.factor(ca),
         thal =  as.factor(thal),
         target = if_else(target == 1,"YES","NO")
         ) %>%
mutate_if(is.character,as.factor) %>%
dplyr::select(target,sex,fbs,exang,cp,restecg,slope,ca,thal,everything())




         
         

#Data Visualization

#BAR PLOT FOR TARGET(HEART DISEASE)
ggplot(data2 , aes(x=data2$target,fill=data2$target))+
   geom_bar()+
   xlab("Heart Disease")+
   ylab("count")
   ggtitle("Presence & Absence of Heart Disease")+
   scale_fill_discrete(name="Heart Disease",labels=c("Absence","Presence"))

prop.table(table(data2$target))

#count the frequency of the value of age
data2 %>%
  group_by(ï..age) %>%
  count() %>%
  filter(n>10) %>%
  ggplot()+
  geom_col(aes(ï..age,n),fill ="green")+
  ggtitle("Age Analysis")+
  xlab("Age")+
  ylab("Agecount")

#compare blood pressure across the chest pain
data2 %>%
  ggplot(aes(x=sex,y=trestbps))+
  geom_boxplot(fill="purple")+
  xlab('sex')+
  ylab('BP')+
  facet_grid(~cp)

#Correlation

install.packages("corrplot")
install.packages("ggplot2")

library(corrplot)
library(ggplot2)

cor_heart <- cor(data2[, 10:14])
cor_heart

corrplot(cor_heart,method='square',type="upper")

??method


cor_heart <- cor(data2[, 10:14])
cor_heart

corrplot(cor_heart,method='shade',type="full")
