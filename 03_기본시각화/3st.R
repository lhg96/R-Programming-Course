library(ggplot2)
mtcars

plot(mtcars)
plot(1,2)
plot(c(1,2), c(4,5))

tail(mtcars,6)
summary(mtcars)
dim(mtcars)
dplyr::glimpse(mtcars)
plot(cars)
plot(mpg~disp, data=mtcars)
plot(mpg~am, data=mtcars)
plot(mpg~factor(am), data=mtcars)

coplot(mpg~disp | factor(am),data=mtcars)
library(rmarkdown) # 마크다운운

par(mfrow=c(2,2))
plot(1:10)
plot(1:10, type="p")
plot(1:10, type="l")
plot(1:10, type="b")

par(mfrow=c(1,1))
x = rep(1:5, each=5);x
y = rep(5:1, 5);y

# no plotting
plot(1:5,type="n",xlim=c(0,7.5),ylim=c(0,5.5))

points(x,y,pch=1:25,cex=2)

text(x-0.5, y, labels=as.character(1:25), cex=1.5)

points(rep(6,5),5:1, pch=65:69, cex=2)

# A~E ascii 출력
text(rep(6,5)-0.5,5:1,labels=as.character(65:69),cex=1.5)

# 특정 문자 출력
pchs=c("&","z","M","F","가")
points(rep(7,5),5:1,pch=pchs,cex=2,family="AppleGothic")

text(rep(7,5)-0.5,5:1,labels=pchs,cex=1.5,family="AppleGothic")


plot(mpg~disp,data=mtcars)

# y~x graph-2
plot(mpg~disp,data=mtcars,
     pch=21,col="black",
     bg=mtcars$am+2,cex=1.2,
     main="연비와 배기량",
     xlab="배기량(cu.in)",ylab="연비(mile per gallon)",
     xlim=c(0,500),ylim=c(0,40),family="AppleGothic")

install.packages("treemap")


bloodType <- c('A','B','A','AB','O','A','O','B','A','O','O','B','O','A','AB','B','O','A')

length(bloodType)
table_bloodType = table(bloodType)
table_bloodType
names(table_bloodType)
sum(table_bloodType)
addmargins(table(bloodType))
pie(x=table(bloodType))
pie(x=table(bloodType)
    , labels=c("A형","AB형","B형","O형")
    , col=c("chocolate1", "chartreuse2", "darkgoldenrod1", "darkorchid1")
    , lty=2
    ,main="혈액형 분포"
    )

pie(x=table(bloodType), col=c("blue", "skyblue", "lightcyan", "cyan"))

colors()

pie(x=table(bloodType), col=heat.colors(4))

table(bloodType)

# 혈액형 분포를 막대차트로 표현
barplot(table(bloodType))
# 막대 이름, 차트 제목, x축 이름, y축 이름, 색상 지정
barplot(table(bloodType)
        , names.arg=c("A형", "AB형", "B형", "O형")
        , main="혈액형 분포"
        , xlab="혈액형"
        , ylab="학생수"
        , col=heat.colors(4)
)

# classDf 구조 보기 – 20개 행, 3개 칼럼[이름(name) 성별(gender) 혈액형(bloodType)]

classDf <- read.csv("boodType.csv")
str(classDf)

classDf

# addmargins 함수를 활용해 합계 행과 열 추가
addmargins(table(classDf[ , c(2,3)]))
head(classDf[, c(2,3)])


classTable <- table(classDf[, c(2,3)])
barplot(classTable)

# 범례 추가
barplot(classTable, legend=TRUE)

barplot(classTable
        , legend = TRUE, ylim=c(0,8))

# 색상 지정하기
barplot(classTable, legend=TRUE, ylim=c(0, 8), col=c("skyblue", "lightpink"))

# beside 입력 항목을 활용해 성별을 별도 막대로 표기. 범례 영역을 위해 y축 길이를 설정(ylim)
barplot(classTable, legend=TRUE, ylim=c(0, 8), col=c("skyblue", "lightpink"), beside=T)

install.packages("ggplot2")
library(ggplot2)

classCovDF <- as.data.frame(classTable)
classCovDF

# ggplot 함수 실행. aes를 통해 x/y축에 매핑할 데이터 항목을 지정
ggplot(classCovDF, aes(x=bloodType, y=Freq))


# 막대차트 만들기
ggplot(classCovDF, aes(x=bloodType ,y=Freq)) + geom_col()


# aes에 색상 채우기(fill)와 성별 항목 연결 추가
ggplot(classCovDF, aes(x=bloodType, y=Freq)) + geom_col(aes(fill=gender))

# 막대차트 만들기
ggplot(classCovDF, aes(x=bloodType ,y=Freq)) + geom_line()


# geom_point 추가. 점의 모양과 성별
ggplot(classCovDF, aes(x=bloodType,y=Freq)) + geom_col(aes(fill=gender)) + geom_point(aes(shape=gender), size=3)



# 그래프 객체 생성
BloodbarChart <- ggplot(classCovDF, aes(x=bloodType, y=Freq)) + 
    geom_col(aes(fill=gender)) +
    ggtitle("혈액형 비율", subtitle="(혈액형/성별 기준)") + 
    labs(x="혈액형", y="인원수", fill="성별")

# theme_void 적용
BloodbarChart + theme_void()

# theme_dark 적용
BloodbarChart + theme_dark()

# theme_minimal 적용
BloodbarChart + theme_minimal()

# theme_classic 적용
BloodbarChart + theme_classic()

# + 기호를 행이 시작하는 위치에 입력 – 다른 명령어로 인식해 오류가 발생
ggplot(classDf, aes(x=bloodType, fill=gender)) + geom_bar()

# + 기호는 이전 함수 뒤에 표현 – 정상 처리됨
ggplot(classDf, aes(x=bloodType, fill=gender)) + geom_bar()

# A, B회사의 매출 실적 데이터프레임 만들기
company <- c('A', 'A', 'A', 'A', 'B', 'B', 'B', 'B')
year <- c('1980', '1990', '2000', '2010', '1980', '1990', '2000', '2010')
sales <- c(2750, 2800, 2830, 2840, 2760, 2765, 2775, 2790)

coSalesDF <- data.frame(company, year, sales)

# 생성된 coSalesDF 확인
coSalesDF

# 라인차트 생성 - x축은 연도(year), y축은 매출(sales) 매칭
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(aes(group=company))


str(cars)

plot(cars$speed, cars$dist
     , xlab ="속도"
     , ylab = "제동거리"
     )

lines(lowess(cars$speed, cars$dist))

str(iris)
summary(iris)
table(iris)
plot(iris)
plot(iris$Petal.Width, iris$Petal.Length)

levels(iris$Species)
#-------------------------------------------------------------

# iris 데이터셋
str(iris)

# 꽃받침(sepal) 길이와 너비의 상관계수 산출
cor(iris$Sepal.Length, iris$Sepal.Width)

# 꽃받침(sepal) 길이와 너비
plot(iris$Sepal.Length, iris$Sepal.Width)

# 꽃잎(Petal) 길이와 너비의 상관계수 산출
cor(iris$Petal.Length, iris$Petal.Width)

# 꽃잎(Petal) 길이와 너비의 산점도
plot(iris$Petal.Length, iris$Petal.Width)

library(treemap)
sales_df = read.csv("sales_df.csv")
str(sales_df)

treemap(sales_df, vSize="saleAmt", index = c("product", "region"), title="A기업 판매현황")


# 트리맵 그리기
treemap(sales_df, vSize="saleAmt", index=c("region", "product"), title="A기업 판매현황")

# 그래프 공간 만들기
ggplot(data=mpg, aes(x=displ, y=hwy))

ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6)
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()

ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
    geom_point() +
    xlim(0, 50000) + 
    ylim(0, 1000)

library(dplyr)
df_mpg <- mpg %>%
    group_by(drv) %>%
    summarise(mean_hwy = mean(hwy))

df_mpg
ggplot(data=df_mpg, aes(x=drv, y=mean_hwy))+geom_col()
ggplot(data=df_mpg, aes(x=reorder(drv,-mean_hwy), y=mean_hwy))+geom_col()

ggplot(data = mpg, aes(x=drv))+geom_bar()

#--------------------------------------------
#26p
ggplot(data=mtcars) + 
    geom_histogram(mapping=aes(x=hp))

ggplot(data=mtcars) + 
    geom_histogram()

ggplot(data=mtcars) +
    geom_bar(mapping =aes(x =cyl))


ggplot(mtcars, aes(hp))+geom_histogram()

ggplot(data=mtcars) +
    geom_bar(mapping = aes(x = cyl, fill=as.factor(am)))

#positon = "stack"은 값을 위로 쌓아 누적 막대 그래프를 생성
ggplot(data=mtcars) +
    geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "stack")

#position = "dodge"는 값을 옆으로 겹치지 않게 하여 그래프를 생성
ggplot(data=mtcars) +
    geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "dodge")


#값들이 겹치지 않도록 값들을 약간씩 움직이는 것을 의미. 범주형 자료에는 유용하지 않음
ggplot(data=mtcars) +
    geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "jitter")

#facet()
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
    geom_point()

#축, 그래프 제목 설정 방법1
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
    geom_point() + 
    labs(x="HP(마력)",y="MPG(연비)", title="HP와 MPG의 관계1")

#축, 그래프 제목 설정 방법2
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
    geom_point() + 
    ggtitle("HP과 MPG의 관계1") + 
    xlab("HP(마력)") + 
    ylab("MPG(연비)")
