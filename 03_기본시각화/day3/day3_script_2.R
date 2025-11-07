#=============================================================
# 범주형 데이터 - pie(), barplot()
#=============================================================

# 혈액형
bloodType <- c('A','B','A','AB','O','A','O','B','A','O','O','B','O','A','AB','B','O','A')

# 총 몇 명의 혈액형인가? (벡터 길이 확인)
length(bloodType)

#-------------------------------------------------------------

# 혈액형별 건수 보기
table(bloodType)

#-------------------------------------------------------------

# table 함수의 결과 객체 생성
table_bloodType <- table(bloodType)

# 결과 조회
table_bloodType

# 범주 확인하기
names(table_bloodType)

# 전체 합계 구하기
sum(table_bloodType)

#-------------------------------------------------------------

# 총계 붙여보기
addmargins(table(bloodType))

#-------------------------------------------------------------

# 파이차트 생성
pie(x=table(bloodType))

#-------------------------------------------------------------

# 라벨명, 색상, 선 종류, 차트 제목 지정
pie(x=table(bloodType)
, labels=c("A형", "AB형", "B형", "O형")
, col=c("chocolate1", "chartreuse2", "darkgoldenrod1", "darkorchid1")
, lty=2
, main="혈액형 분포")

#-------------------------------------------------------------

# 색상명으로 색상 설정
pie(x=table(bloodType), col=c("blue", "skyblue", "lightcyan", "cyan"))

#-------------------------------------------------------------

colors()

#-------------------------------------------------------------

# heat.colors를 이용해 4개의 색상을 자동으로 선정
pie(x=table(bloodType), col=heat.colors(4))

#-------------------------------------------------------------

table(bloodType)

# 혈액형 분포를 막대차트로 표현
barplot(table(bloodType))

#-------------------------------------------------------------

# 막대 이름, 차트 제목, x축 이름, y축 이름, 색상 지정
barplot(table(bloodType)
, names.arg=c("A형", "AB형", "B형", "O형")
, main="혈액형 분포"
, xlab="혈액형"
, ylab="학생수"
, col=heat.colors(4)
)

#-------------------------------------------------------------

# classDf 구조 보기 – 20개 행, 3개 칼럼[이름(name) 성별(gender) 혈액형(bloodType)]

classDf <- read.csv("D:/boodType.csv")
str(classDf)

# 혈액형 조사자료
classDf

#-------------------------------------------------------------

# classDf 2,3열의 첫 6행 보기
head(classDf[ , c(2,3)])

# classDf 중 성별(gender)과 혈액형(bloodType) 열만 선택해서 table 객체를 생성
table(classDf[ , c(2,3)])

# addmargins 함수를 활용해 합계 행과 열 추가
addmargins(table(classDf[ , c(2,3)]))

#-------------------------------------------------------------

# table 함수의 결괏값 객체 생성
classTable <- table(classDf[ , c(2, 3)])

# 막대차트를 활용해 성별과 혈액형별 분포 확인
barplot(classTable)

#-------------------------------------------------------------

# 범례 추가
barplot(classTable, legend=TRUE)

#-------------------------------------------------------------

# y축을 0 ~ 8까지 출력하도록 설정
barplot(classTable, legend=TRUE, ylim=c(0,8))

#-------------------------------------------------------------

# 색상 지정하기
barplot(classTable, legend=TRUE, ylim=c(0, 8), col=c("skyblue", "lightpink"))

#-------------------------------------------------------------

# beside 입력 항목을 활용해 성별을 별도 막대로 표기. 범례 영역을 위해 y축 길이를 설정(ylim)
barplot(classTable, legend=TRUE, ylim=c(0, 8), col=c("skyblue", "lightpink"), beside=T)

#=============================================================
# ggplot2 패키지
#=============================================================
# 혈액별/성별 간 빈도수가 표현된 테이블 객체
classTable

# 데이터프레임 변환
classCovDF <- as.data.frame(classTable)

# 데이터프레임 변환 결과
classCovDF

# ggplot 함수 실행. aes를 통해 x/y축에 매핑할 데이터 항목을 지정
ggplot(classCovDF, aes(x=bloodType, y=Freq))

#-------------------------------------------------------------

# 막대차트 만들기
ggplot(classCovDF, aes(x=bloodType ,y=Freq)) + geom_col()

#-------------------------------------------------------------

# aes에 색상 채우기(fill)와 성별 항목 연결 추가
ggplot(classCovDF, aes(x=bloodType, y=Freq)) + geom_col(aes(fill=gender))

#-------------------------------------------------------------

# geom_point 추가. 점의 모양과 성별
ggplot(classCovDF, aes(x=bloodType,y=Freq)) + geom_col(aes(fill=gender)) + geom_point(aes(shape=gender), size=3)

#-------------------------------------------------------------

# geom_line 추가. 선 연결 기준(group)과 선 모양(linetype)을 성별과 연결한 aes 정보 추가
ggplot(classCovDF, aes(x=bloodType, y=Freq)) + geom_col(aes(fill=gender))+ geom_point(aes(shape=gender),size=3) + geom_line(aes(group=gender,linetype=gender))

#-------------------------------------------------------------

# ggplot의 제목 추가하기
ggplot(classCovDF, aes(x=bloodType, y=Freq)) + geom_col(aes(fill=gender)) + ggtitle("혈액형 비율", subtitle="(혈액형/성별 기준)")

#-------------------------------------------------------------

# ggplot의 x/y축 및 범례 제목 변경
ggplot(classCovDF, aes(x=bloodType, y=Freq)) + geom_col(aes(fill=gender)) + ggtitle("혈액형 비율", subtitle="(혈액형/성별 기준)") + labs(x="혈액형", y="인원수", fill="성별")

#-------------------------------------------------------------

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

#-------------------------------------------------------------

# + 기호를 행이 시작하는 위치에 입력 – 다른 명령어로 인식해 오류가 발생
ggplot(classDf, aes(x=bloodType, fill=gender)) + geom_bar()

#-------------------------------------------------------------

# + 기호는 이전 함수 뒤에 표현 – 정상 처리됨
ggplot(classDf, aes(x=bloodType, fill=gender)) + geom_bar()

#-------------------------------------------------------------

# 혈액형별 빈도수가 이미 계산된 경우
col_data

# x축에 혈액형, y축에 이미 계산된 빈도수를 연결해서 geom_col 함수로 막대차트를 생성
ggplot(col_data, aes(x=bloodType, y=Freq)) + geom_col()

#-------------------------------------------------------------

# 혈액형 정보가 나열돼 있음
bar_data

# x축에 혈액형을 연결하면 y축은 자동으로 빈도수를 계산해 표현
ggplot(bar_data, aes(x=bloodType)) + geom_bar()

#=============================================================
#시간의 흐름에 따라 보기
#=============================================================

# A, B회사의 매출 실적 데이터프레임 만들기
company <- c('A', 'A', 'A', 'A', 'B', 'B', 'B', 'B')
year <- c('1980', '1990', '2000', '2010', '1980', '1990', '2000', '2010')
sales <- c(2750, 2800, 2830, 2840, 2760, 2765, 2775, 2790)

coSalesDF <- data.frame(company, year, sales)

# 생성된 coSalesDF 확인
coSalesDF

#-------------------------------------------------------------

# 라인차트 생성 - x축은 연도(year), y축은 매출(sales) 매칭
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(aes(group=company))

#-------------------------------------------------------------

# 선 색상 및 두께 설정
ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company,colour=company))

#-------------------------------------------------------------

ggplot(coSalesDF, aes(x=year, y=sales)) + geom_line(size=2, aes(group=company, colour=company)) + geom_point(size=2)

#=============================================================
#상관관계 보기
#=============================================================

# cars 데이터 구조
str(cars)

#-------------------------------------------------------------

# plot (x축 데이터, y축 데이터, 옵션)
plot(cars$speed, cars$dist, xlab="속도", ylab="제동거리")

#-------------------------------------------------------------

# lowess 함수로 나온 회귀분석 추정치를 lines라는 함수를 통해 기존 그래프에 선을 추가
# 추세선
lines(lowess(cars$speed, cars$dist))

#-------------------------------------------------------------

# iris 데이터 구조
str(iris)

# 팩터 레벨 확인
levels(iris$Species)

# 데이터 프레임 내 모든 항목 간의 산점도 확인
plot(iris)

#-------------------------------------------------------------

plot(iris$Petal.Width, iris$Petal.Length)

#-------------------------------------------------------------

# 팩터 레벨 확인
levels(iris$Species)

#-------------------------------------------------------------

# iris 데이터셋
str(iris)

# 꽃받침(sepal) 길이와 너비의 상관계수 산출
cor(iris$Sepal.Length, iris$Sepal.Width)

#-------------------------------------------------------------

# 꽃받침(sepal) 길이와 너비
plot(iris$Sepal.Length, iris$Sepal.Width)

#-------------------------------------------------------------

# 꽃잎(Petal) 길이와 너비의 상관계수 산출
cor(iris$Petal.Length, iris$Petal.Width)

# 꽃잎(Petal) 길이와 너비의 산점도
plot(iris$Petal.Length, iris$Petal.Width)

#=============================================================
# 트리맵
#=============================================================

# 데이터파일 엑셀(dataset.xlsx)에서 "sales_df" Sheet 복사 후 
# 아래 명령어를 실행 해 데이터 프레임 생성  


# A기업의 판매현황 – 상품(product), 지역(region), 매출(saleAmt)
str(sales_df)

# 데이터 보기
sales_df

#-------------------------------------------------------------

# 트리맵 라이브러리 설치
install.packages("treemap")

# 트리맵 메모리 로드
library(treemap)

#-------------------------------------------------------------

# 트리맵 그리기
# index에 표현하고 싶은 계층 순서대로 벡터로 생성. product, region 순으로 벡터를 지정함으로써 product가 region보다 더 상위로 구분이 됨
treemap(sales_df, vSize="saleAmt", index=c("product", "region"), title="A기업 판매현황")

#-------------------------------------------------------------

# 트리맵 그리기
treemap(sales_df, vSize="saleAmt", index=c("region", "product"), title="A기업 판매현황")