#5 days

#패키지 실행 및 데이터 가져오기
install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss(file="Koweps_hpc10_2015_beta1.sav", to.data.frame=T)
View(head(raw_welfare))

#복사본 만들기
welfare <- raw_welfare

View(head(welfare))
head(welfare)
dim(welfare)
str(welfare)
summary(welfare)

names(welfare)

#변수명 변경
welfare <- dplyr::rename(welfare,
                         sex = h10_g3, # 성별
                         birth = h10_g4, # 태어난 연도
                         marriage = h10_g10, # 혼인 상태
                         religion = h10_g11, # 종교
                         income = p1002_8aq1, # 월급
                         code_job = h10_eco9, # 직업 코드
                         code_region = h10_reg7 # 지역 코드
)

head(welfare$sex, 5)

# 데이터의 일부 컬럼 추출:부분집합 subset
welfare_subset <- subset(welfare, 
                         select = c(sex, birth, marriage, religion, income, code_job, code_region))

#1. 성별에 따른 월급 차이
# 변수 검토
class(welfare$sex)
table(welfare$sex)

# 이상치(Outlier) 결측 (NA)
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)  # ifelse(조건, 조건 참일 경우 값, 거짓일 경우 값)
table(is.na(welfare$sex))

# 성별 항목 이름 부여
welfare$sex <-  ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)

# 급여(월급) 변수 검토 및 전처리
class(welfare$income)
summary(welfare$income)
qplot(welfare$income)
qplot(welfare$income)+ xlim(0,1000)

# 월급 이상치 결측처리
summary(welfare$income)
welfare$income <- ifelse(welfare$income %in% c(0,9999),NA,welfare$income)

table(is.na(welfare$sex))
qplot(welfare$income)

sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(sex) %>%
  summarise(mean_income = mean(income))

sex_income

ggplot(data = sex_income, aes(x = sex, y = mean_income)) + 
  geom_col()

sex_income_dat <- welfare %>% 
  filter(!is.na(income)) %>% 
  dplyr::select(sex, income)

table(sex_income_dat$sex)  #t검정
t.test(data=sex_income_dat, income~sex, var.equal=T)

#2. 나이와 월급의 관계
#변수 검토
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

#이상치 확인
summary(welfare$birth)

#결측치 확인
table(is.na(welfare$birth))

# 이상치 결측 처리
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

#나이 파생변수 만들기
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)

#나이에 따른 월급 평균표 만들기
age_income <- welfare %>% 
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))

head(age_income)

#그래프 만들기
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()

#3. 연령대에 따른 월급 차이
#파생변수 만들기-연령대
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))

table(welfare$ageg)

qplot(welfare$ageg)

#연령대에 따른 월급 차이 분석
#파생변수 만들기-연령대
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))

table(welfare$ageg)
qplot(welfare$ageg)

ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))

ageg_income

#그래프 만들기
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col()

#scale_x_discrete(limits = c())에 범주 순서를 지정
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + 
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

##--------------------------------------
#4. 연령대 및 성별에 따른 월급 차이
#연령대 및 성별 월급 평균표 만들기 
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))

sex_income
#t.test(data = sex_income, mean_income~sex, var.equal=T)

ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))

#'dodge' 성별막대 분리
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("young", "middle", "old"))

# 성별 연령별 월급 평균표 만들기
sex_age <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(age, sex) %>% 
  summarise(mean_income = mean(income))

head(sex_age)

# 그래프 만들기
ggplot(data = sex_age, aes(x = age, y = mean_income, col = sex)) + 
  geom_line()

#연령대 및 성별 월급 평균표 만들기 
age_sex_income <- welfare %>%
  filter(!is.na(income)) %>%  
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))  
age_sex_income

#그래프 만들기
ggplot(data = age_sex_income, aes(x = ageg, y = mean_income, fill = sex)) +  
  geom_col() +
  scale_x_discrete(limits = c("20대이하", "30대", "40대", "50대", "60대", "70대이상"))

#성별막대 분리
ggplot(data = age_sex_income, aes(x = ageg, y = mean_income, fill = sex)) +  
  geom_col(position = "dodge") +
  scale_x_discrete(limits = c("20대이하", "30대", "40대", "50대", "60대", "70대이상"))

#연령대 및 성별 월급 평균표 만들기  
age_sex_income <- welfare %>%
  filter(!is.na(income)) %>%  
  group_by(age, sex) %>%
  summarise(mean_income=mean(income))

#그래프 만들기
ggplot(data = age_sex_income, aes(x = age, y = mean_income, col = sex)) +
  geom_line()

#Two-way ANOVA
#연령대 및 성별 월급 평균표 만들기  age_sex_income <- welfare %>%
filter(!is.na(income)) %>%  
  select(ageg, sex, income)

head(age_sex_income,5)

rst2<-aov(income~ageg+sex, data=age_sex_income)
summary(rst2)

#5. iris 월급 차이  
class(welfare$code_job)

table(welfare$code_job)

#직업분류 코드 불러오기  
library(readxl)
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet = 2)  
head(list_job)
dim(list_job)

#welfare에 직업명 결합
welfare <- left_join(welfare, list_job, id = "code_job")

#데이터 확인
welfare %>%  
  filter(!is.na(code_job)) %>%  
  select(code_job, job) %>%  
  head(10)

#직업별 월급 평균표 만들기  
job_income <- welfare %>%
  filter(!is.na( job) & !is.na(income)) %>%  
  group_by( job) %>%  
  summarise(mean_income = mean(income))
head( job_income)

#상위 10개 추출
top10 <- job_income %>%  
  arrange(desc(mean_income)) %>%  
  head(10)
top10

#그래프 그리기
ggplot(data = top10, aes(x = reorder( job, mean_income), y = mean_income)) +
  geom_col() +
  coord_flip()

#하위 10개 추출
bottom10 <- job_income %>%  arrange(mean_income) %>%  head(10)

ggplot(data = bottom10, aes(x = reorder( job, -mean_income),  y = mean_income)) +
  geom_col() +  coord_flip() +  ylim(0, 150)

#One-way ANOVA 데이터 추출  
job_income <- welfare %>%
  filter(!is.na( job) & !is.na(income)) %>%
  select( job, income)

rst3<-aov(income~job, data=job_income)  
summary(rst3)

# 남성 직업 빈도 상위 10개 추출  
job_male <- welfare %>%
  filter(!is.na( job) & sex == "male") %>%
  group_by( job) %>%  
  summarise(n = n()) %>%  
  arrange(desc(n)) %>%  
  head(10)
job_male
ggplot(data = job_male, aes(x = reorder( job, n), y = n)) +   geom_col() +
  coord_flip()

# 여성 직업 빈도 상위 10개 추출  
job_female <- welfare %>%
  filter(!is.na( job) & sex == "female") %>%
  group_by( job) %>%  
  summarise(n = n()) %>%  
  arrange(desc(n)) %>%  
  head(10)
job_female
ggplot(data = job_female, aes(x = reorder( job, n), y = n)) +   geom_col() +
  coord_flip()

#종교여부에 따른 이혼률  class(welfare$religion)  
table(welfare$religion)

# 종교 유무 이름 부여
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")  
table(welfare$religion)

qplot(welfare$religion)

#혼인상태 변수 검토  
class(welfare$marriage)

table(welfare$marriage)

# 이혼 여부 변수 만들기
welfare$group_marriage  <- ifelse(welfare$marriage  == 1, "marriage",
                                  ifelse(welfare$marriage  == 3, "divorce", NA))

table(welfare$group_marriage)  
table(is.na(welfare$group_marriage))  
qplot(welfare$group_marriage)

#종교여부에 따른 이혼률  
class(welfare$religion)  
table(welfare$religion)

# 종교 유무 이름 부여
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")  
table(welfare$religion)

qplot(welfare$religion)

#혼인상태 변수 검토  
class(welfare$marriage)

table(welfare$marriage)

# 이혼 여부 변수 만들기
welfare$group_marriage  <- ifelse(welfare$marriage  == 1, "marriage",
                                  ifelse(welfare$marriage  == 3, "divorce", NA))

table(welfare$group_marriage)  
table(is.na(welfare$group_marriage))  
qplot(welfare$group_marriage)

#종교유무에 따른 이혼률표 생성  
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%  
  group_by(religion, group_marriage) %>%  
  summarise(n = n()) %>%  
  mutate(tot_group = sum(n)) %>%  
  mutate(pct = round(n/tot_group*100, 1))
religion_marriage  
#count() 이용
religion_marriage <- welfare %>%  
  filter(!is.na(group_marriage)) %>%  
  count(religion, group_marriage) %>%  
  group_by(religion) %>%
  mutate(pct = round(n/sum(n)*100, 1))

#이혼 추출
divorce <- religion_marriage %>%  
  filter(group_marriage == "divorce") %>%  
  select(religion, pct)
divorce
ggplot(data = divorce, aes(x = religion, y = pct)) + geom_col()

#연령대별 이혼률 생성  
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%  
  group_by(ageg, group_marriage) %>%  
  summarise(n = n()) %>%  
  mutate(tot_group = sum(n)) %>%  
  mutate(pct = round(n/tot_group*100, 1))
ageg_marriage

#count() 활용
ageg_marriage <- welfare %>%  
  ilter(!is.na(group_marriage)) %>%  
  count(ageg, group_marriage) %>%  
  group_by(ageg) %>%
  mutate(pct = round(n/sum(n)*100, 1))

#이혼률 추출
ageg_divorce <- ageg_marriage %>%  
  filter(group_marriage == "divorce") %>%  
  select(ageg, pct)
ageg_divorce

ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) + geom_col()

# 연령대, 종교유무, 결혼상태별 비율표 만들기  
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%  
  group_by(ageg, religion, group_marriage) %>%  
  summarise(n = n()) %>%
  mutate(tot_group = sum(n)) %>%  
  mutate(pct = round(n/tot_group*100, 1))

ageg_religion_marriage

#연령대 및 종교 유무별 이혼율 표 만들기  
df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorce") %>%  
  select(ageg, religion, pct)

df_divorce

ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion )) +     geom_col(position = "dodge")

class(welfare$code_region)  
table(welfare$code_region)

# 지역 코드 목록 만들기
df_region <- data.frame(code_region = c(1:7),
                        region = c("서울",
                                   "수도권(인천/경기)",  "부산/경남/울산", 
                                   "대구/경북",
                                   "대전/충남",
                                   "강원/충북",  
                                   "광주/전남/전북/제주도"))
df_region

#welfare에 지역명 변수 추가
welfare <- left_join(welfare, df_region, id = "code_region")

#데이터 확인  welfare %>%
select(code_region, region) %>%  
  head

#지역별 연령대 비율표 만들기  
region_ageg <- welfare %>%
  group_by(region, ageg) %>%  
  summarise(n = n()) %>%  
  mutate(tot_group = sum(n)) %>%  
  mutate(pct = round(n/tot_group*100, 2))
head(region_ageg)  #그래프 만들기
ggplot(data = region_ageg, aes(x = region, y = pct, fill = ageg)) +
  geom_col() +  coord_flip()

#노년층 비율 내림차순 정렬  
list_order_old <- region_ageg %>%
  filter(ageg == "70대이상") %>%  arrange(pct)
list_order_old

# 지역명 순서 변수 만들기  
order <- list_order_old$region  
order

ggplot(data  = region_ageg,  aes(x = region, y = pct, fill = ageg)) +  geom_col() +
  coord_flip() +  
  scale_x_discrete(limits = order)

str(iris)
f1 <- ggplot(iris, aes(x=Species, y=Petal.Length)) +
  geom_boxplot() +
  ggtitle(("Boxplot of Petal.Length"))
f1

f2<-f1+scale_x_discrete(limits=c("virginica", "versicolor", "setosa")) +  ggtitle("Changed Order of x axis by scale_x_discrete(limit=...)")
f2
#day5-1-------------------------------------

View(cars)
str(cars)
lm_result = lm(formula = dist~speed, data=cars)
summary(lm_result)
coef(lm_result)
confint(lm_result)

residuals(lm_result)

plot(cars$speed, cars$dist)

lm_result <-lm(formula = dist~speed, data=cars)
abline(lm_result)


#-------------------------------------------------------------

# 가로 2, 세로 2개의 그래프를 한 번에 그리도록 설정
par(mfrow=c(2, 2))

# 회귀분석 결과 그래프 출력
plot(lm_result)

#-------------------------------------------------------------

# "차속도"에 따른 "제동거리" 회귀분석
lm_result <- lm(formula=dist~speed, data=cars)

# 예측할 독립변수 데이터프레임 생성
# 데이터프레임을 생성할 때는 회귀분석 시 사용한 독립변수명과 동일하게 칼럼명을 생성
speed <- c(50, 60, 70, 80, 90, 100)
df_input <- data.frame(speed)

# 입력값 확인
df_input


# 예측 – 점 추정 방식(interval 옵션을 생략하면 점 추정 방식을 적용)
predict(lm_result, df_input)

#-------------------------------------------------------------

# predict 결괏값 SET
predict_dist <- predict(lm_result, df_input)

# predict 결괏값 구조 확인 -> 숫자로 된 1차 배열
str(predict_dist)

# cbind를 이용해 연결(두 개의 데이터프레임을 단순 가로로 연결)
cbind(df_input, predict_dist)

#-------------------------------------------------------------

# 모델계수에 대한 불확실성을 감안한 구간 추정(confidence) / 신뢰구간 95%
predict_dist <- predict(lm_result, df_input, interval="confidence", level=0.95)

# 예측 결과
predict_dist

# 입력값과 함께 보기
cbind(df_input, predict_dist)

#-------------------------------------------------------------

# 모델계수에 대한 불확실성 + 결괏값에 대한 오차를 감안한 구간 추정 / 신뢰구간 95%
predict_dist <- predict(lm_result, df_input, interval="prediction", level=0.95)

# 입력값과 함께 보기
cbind(df_input, predict_dist)

#-------------------------------------------------------------

# 정수기 데이터프레임
# purifier: 전월 정수기 총 대여 수
# old_purifier: 전월 10년 이상 노후 정수기 총 대여 수
# as_time: 당월 AS에 소요된 시간
summary(purifier_df)

#-------------------------------------------------------------

# 전월 정수기 총 대여 수 vs. 10년 이상 정수기 상관성 분석
cor(purifier_df$purifier, purifier_df$old_purifier)

#-------------------------------------------------------------

# 10년 미만 정수기 = 총 대여 수 - 10년 이상 정수기
# 10년 미만 정수기 vs. 10년 이상 정수기 상관성 분석
cor((purifier_df$purifier - purifier_df$old_purifier), purifier_df$old_purifier)

#-------------------------------------------------------------

# 정수기 데이터프레임 확인
str(purifier_df)

# 10년 미만 정수기 대여 수(new_purifier) 추가 (총 대여 수 - 10년 이상 정수기)
purifier_df$new_purifier <- purifier_df$purifier - purifier_df$old_purifier

# 정수기 데이터프레임 확인
str(purifier_df)

#-------------------------------------------------------------

# 회귀분석 수행(lm)
# 종속변수: AS시간(as_time)
# 독립변수: 10년 미만 정수기(new_purifier), 10년 이상 정수기(old_purifier)
lm_result <- lm(as_time ~ new_purifier + old_purifier, data=purifier_df)

#-------------------------------------------------------------

# 결괏값 확인
summary(lm_result)

#-------------------------------------------------------------

# 예측할 독립변수 값 설정(데이터프레임)
input_predict <- data.frame(new_purifier=300000, old_purifier=70000)

# 예측값 저장
predict_as_time <- predict(lm_result, input_predict)

# 예측값 출력
predict_as_time

# AS기사 1명이 한 달간 처리하는 AS시간 = 8시간 * 20일
predict_as_time /(8*20)

#-------------------------------------------------------------

# 구간 추정
predict_as_time <- predict(lm_result, input_predict, interval="confidence", level=0.95)

# 익월 AS시간이 '43,414시간' ~ '43,824시간'이 될 가능성을 95%로 예측
predict_as_time

#-------------------------------------------------------------

# iris 데이터 구조
# 꽃 종류(Species)
# 꽃받침의 길이와 폭(Sepal.Length, Sepal.Width)
# 꽃잎의 길이와 폭(Petal.Length, Petal.Width)
str(iris)

# 팩터 레벨 확인(꽃 종류)
levels(iris$Species)

#-------------------------------------------------------------

# 데이터 총 건수
nrow(iris)
variable.names(iris)

# 꽃 종류별 개수
table(iris$Species)

#-------------------------------------------------------------

# 최초 실행 시 패키지 설치
install.packages("caret")

# 패키지 로드
library(caret)

# createDataPartition을 활용해 추출할 위치 정보를 벡터로 반환받음(list=FALSE)
# iris$Species 기준으로 각 종류별로 80%씩 도출
iris_row_idx <- createDataPartition(iris$Species, p=0.8, list=FALSE)

# 결괏값 확인(데이터프레임에서 추출할 행 번호를 얻음)
str(iris_row_idx)

# 추출한 위치 정보를 활용해 iris 데이터셋에서 훈련 데이터 추출
iris_train_data <- iris[iris_row_idx, ]

# 추출한 iris_train_data 확인
str(iris_train_data)

# iris_train_data의 꽃 종류별 데이터 수 확인
table(iris_train_data$Species)

#-------------------------------------------------------------

# 테스트 데이터 추출(iris_row_idx를 제외한 행 데이터 추출)
# 벡터 내 존재하는 인덱스를 제외하라는 의미는 "-" 기호를 이용함
iris_test_data <- iris[-iris_row_idx, ]

# iris_train_data 확인
str(iris_test_data)

# 테스트 데이터 확인(꽃 종류별로 균일하게 10개씩 총 30건을 추출함)
table(iris_test_data$Species)

#-------------------------------------------------------------

# 훈련 데이터 확인
summary(iris_train_data)

# 테스트 데이터 확인
summary(iris_test_data)

# 최초 실행 시 패키지 설치
install.packages("rpart")

# 패키지 로드
library(rpart)

#분류분석 - rpart 함수 실행
#iris_train_data의 모든 항목을 넣기 위해 "." 사용
#Species~. (의미: Species~Sepal.Length+Sepal.Width+Petal.Length+Petal.Width)
iris_rpart_result <- rpart(Species~., data=iris_train_data, control=rpart.control(minsplit=2))

#-------------------------------------------------------------

# 분류분석 결괏값 출력
iris_rpart_result

#-------------------------------------------------------------

# 최초 실행 시 패키지 설치
install.packages("rpart.plot")

# rpart.plot 패키지 로드
library(rpart.plot)

# 의사결정 트리 그래프 출력
rpart.plot(iris_rpart_result)

#-------------------------------------------------------------

# CP 값 조회
iris_rpart_result$cptable

#-------------------------------------------------------------

# 가지치기
iris_prune_tree <- prune(iris_rpart_result, cp=0.0125)

# Decision Tree 그리기
rpart.plot(iris_prune_tree)

#-------------------------------------------------------------

# 테스트 데이터 확인 - 훈련 데이터와 칼럼명이 같아야 함(단 종속변수 칼럼은 없어도 됨)
str(iris_test_data)

# predict 함수 실행
predict(iris_rpart_result, iris_test_data, type="class")

#-------------------------------------------------------------

# 실제 값과 예상 값을 한눈에 볼 수 있게 데이터프레임 만들기
# actual: 실제 값, expect: 예상 값
actual <- iris_test_data$Species
expect <- predict(iris_rpart_result, iris_test_data, type="class")

# 데이터프레임 만들기
iris_predict_df <- data.frame(actual, expect)

# 결괏값 확인
iris_predict_df

#-------------------------------------------------------------

# 혼동행렬 만들기
table(iris_predict_df)

#-------------------------------------------------------------

# 최초 실행 시 패키지 설치
install.packages("caret")
install.packages("e1071")
# 패키지 로드
library(caret)

# confusionMatrix 수행
confusionMatrix(expect, actual, mode="everything")


