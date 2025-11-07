#R java install
#https://blog.naver.com/twilight_teatime/221185099354
install.packages("Runiversal")
install.packages("Rserve")
library(Rserve)
Rserve()
.libPaths()
#----------------------------------------
#R dataset package
#https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/00Index.html
#ctrl + L : clear console

getwd()
setwd("d:/workspace/r")
ls()
a<-1
a
example()
c(a)
seq(a)
var1 = c(1,2,3,4,5)
var1
var2 = c(1:5)
var2
var3 = var1+var2
var3
var4 = c(var1, var2)

c(var1)
var5 = seq(1,5)
var6 = seq(1,5, by=2)
var7 = seq(1,10, by=3)
str1 = "a"
str2 = "b"
str3 = "c"
str4 = c("a","b","c")
str3
install.packages("ggplot2");
library(ggplot2)

mpg
qplot(data = mpg, x= hwy)
qplot(data = mpg, x= displ)
qplot(data = mpg, x= drv, y=hwy)
head(mpg)
tail(mpg)
dim(mpg)
View(mpg)
str(mpg)

iris
str(iris)
View(iris)
qplot(data = iris, x = Sepal.Length )
