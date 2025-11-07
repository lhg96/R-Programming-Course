#-------------------------------------------------------------

# cars 데이터 확인
# speed: 차속도(단위 mi/h), dist: 제동거리(단위: feet)
str(cars)

# "차속도"에 따른 "제동거리" 회귀분석
lm_result <- lm(formula=dist~speed, data=cars)

#-------------------------------------------------------------

# 회귀분석 결과 확인 - summary 함수를 통해 확인
summary(lm_result)

#-------------------------------------------------------------

# "차속도"에 따른 "제동거리" 회귀분석
lm_result <- lm(formula=dist~speed, data=cars)

# 회귀모델 방정식의 기울기와 절편 조회
coef(lm_result)

# 신뢰구간별 기울기와 절편 조회
confint(lm_result)

# 잔차제곱합 - 모델 간 평가 시 사용(작을수록 좋은 모델)
deviance(lm_result)

# 회귀분석 도출에 사용된 독립변수를 가지고 산출한 예측값
fitted(lm_result)

# fitted와 실제 종속변수 값과의 차이(잔차)
residuals(lm_result)

#-------------------------------------------------------------

# plot(x축vector, y축vector)
plot(cars$speed, cars$dist)

#-------------------------------------------------------------

# "차속도"에 따른 "제동거리" 회귀분석
lm_result <- lm(formula=dist~speed, data=cars)

# 회귀모델 방정식 선 그리기
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

# 패키지 로드
library(caret)

# confusionMatrix 수행
confusionMatrix(expect, actual, mode="everything")

#-------------------------------------------------------------