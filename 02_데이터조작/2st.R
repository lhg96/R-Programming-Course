library(ggplot2)
mpg2 <-mpg
mpg2
install.packages("dplyr")
library(dplyr)

df_raw = data.frame(
  var1 = c(1,2,1),
  var2 = c(2,3,2)
)
df_new <- df_raw
df_new

df_new <-rename(df_new, v2= var2)
df_new

str(mpg)
mpg_new  <- mpg
mpg_new <-rename(mpg_new, city=cty, highway=hwy)
str(mpg_new)

df <- data.frame(
  var1 = c(4,3,8),
  var2 = c(2,6,1)
)
df

df$var_sum <- df$var1+df$var2
df

df$var_mean <- (df$var1+df$var2)/2
df

mpg$total <- (mpg$cty+mpg$hwy)/2
head(mpg)
mpg$total
length(mpg$total)


hist(mpg$total)
mpg$test <- ifelse(mpg$total >=20,"pass", "fail")
head(mpg$test, 20)

table(mpg$test)

library(ggplot2)
qplot(mpg$total)
str(mpg)
summary(mpg)
qplot(mpg$test)

mpg$grade<- ifelse(mpg$total>=30,"A" ,ifelse(mpg$total>=20,"B","C"))
head(mpg,20)
table(mpg$grade)
qplot(mpg$grade)
View(mpg)

#---------------------
midwest2 <- midwest
dim(midwest2)
midwest2 <-rename(midwest, total = poptotal, asian = popasian)
str(midwest2)
totalsum = sum(midwest2$total)

getwd()
exam <- read.csv("csv_exam.csv")
exam

exam %>% filter(class == 1)
exam %>% filter(class == 2)
exam %>% filter(english>90)
exam %>% filter(class ==1&english>90)
exam %>% filter(class != 3)
exam %>% filter(math >=90 | english>=90)
exam2 <- exam %>% filter(class ==1 |class ==2 |class ==3)
exam2
table(exam2$class)

exam %>% filter(class %in% c(1, 3, 5))
class1 <- exam %>% filter(class==1)
class2 <- exam %>% filter(class==2)

mean(class1$math)
mean(class2$math)

dplyr::glimpse(mpg)


displ.4 <-mpg %>% filter(mpg$displ<=4)
displ.5 <-mpg %>% filter(mpg$displ>=5)

mean(displ.4$hwy)
mean(displ.5$hwy)

audi <-mpg %>% filter(mpg$manufacturer == 'audi')
toyota <-mpg %>% filter(mpg$manufacturer == 'toyota')
mean(audi$cty)
mean(toyota$cty)
#17page 평균 
mpg_new <- mpg %>% filter(manufacturer %in% c("chevrolet","ford","honda"))
mean(mpg_new$hwy)

View(exam)
dplyr::glimpse(exam)
exam %>% select(math)
exam %>% select(english)
exam %>% select(english, math, class)
exam %>% select(-math)
exam %>% select(-math,-english)

exam %>% select(english, math, class) %>% head(10)


exam %>% arrange(math)
exam %>% arrange(desc(math))
exam %>% arrange(class, math)

mpg_audi <- mpg %>% filter(manufacturer=="audi")
mpg_audi %>% arrange(desc(hwy)) %>% head(5)

View(exam)
exam %>% mutate(total = math+english+science) %>% head
exam %>% mutate(total = math+english+science,
                mean = (math+english+science)/3
                ) %>% head

mpg_total <- mpg %>% mutate(total = cty+hwy)
head(mpg_total)
mpg_total <- mpg %>% mutate(
  total = cty+hwy,
  mean = total/2
)
head(mpg_total)
str(mpg_total)
mpg_view = mpg_total %>% arrange(desc(mean)) %>% head(5)
mpg_view

