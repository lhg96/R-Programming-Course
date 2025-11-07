
#문자열 숫자 벡터 만들기
name = "임현근"
age  = 44
city = "대전"

is.character(name)
is.numeric(age)
is.logical(city)

#a 10번 반복
v5 = rep("A",10)
v5
v6 = seq(from=1,to=20,by=4)
v6
v7 = rep(v6, 5)
v7

v8 <- c(v5,v6,v7)
v8

v9 = v8[seq(1,40,by=2)]
v9
rm(list = ls())
ls

m5 = data.frame(id=c("a","b","c","d"),
           score=c(90,80,70,60),
           gender=factor(c("M","F","M","F"))
           )
summary(m5)
str(df)
df$id[2]
dim(df)

m6 = m5[seq(1,4,by=2),]
m6 = m5[seq(2, nrow(m5),2),]

m7 = m5[m5$score>=80,]
m7

names(m5) <- c("ID","SCORE", "G")
m5
m5$addr = c("Seo","Dae","Bus","Dae")
m5
