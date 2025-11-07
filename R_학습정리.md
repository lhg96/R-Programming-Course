# R 학습 자료 정리

## 📚 학습 개요
- **학습 기간**: 2020년 8월 20일 배재대산단 R 강의
- **목표**: R 기본 문법부터 데이터 분석, 시각화, 머신러닝까지

## 🛠 환경 설정

### R 및 RStudio 설치
- **R 다운로드**: https://cran.r-project.org/bin/windows/base/R-4.0.2-win.exe
- **RStudio 다운로드**: https://rstudio.com/products/rstudio/download/
- **RStudio Cloud**: https://rstudio.cloud/ (설치가 어려운 경우)

### Java 연동 설정
```r
install.packages("Runiversal")
install.packages("Rserve")
library(Rserve)
Rserve()
```

---

## 📖 Day 1: R 기초 문법

### 1. 변수와 대입 연산자
```r
# 변수 생성
love <- 1
love <- "안녕하세요"

# 변수 출력
print(love)
love  # 직접 출력도 가능
```

### 2. 벡터(Vector) 생성과 조작
```r
# 벡터 생성
var1 <- c(1,2,3,4,5)
var2 <- c(1:5)
var3 <- seq(1,5)
var4 <- seq(1,10, by=3)

# 벡터 연산
var3 <- var1 + var2
var4 <- c(var1, var2)  # 벡터 결합
```

### 3. 데이터 타입
- **숫자형(Numeric)**: `c(0.2, -1, 2, -0.5)`
- **논리형(Logical)**: `c(TRUE, FALSE, T, F)`
- **문자형(Character)**: `c("문자열1", "문자열2")`
- **팩터형(Factor)**: `factor(c("남", "여", "남"))`

### 4. 벡터 인덱싱
```r
t_vector <- c(11, 12, 13, 14, 15)

# 위치 인덱싱
t_vector[3]                    # 3번째 요소
t_vector[c(1, 3, 5)]          # 1, 3, 5번째 요소

# 조건 인덱싱
t_vector[t_vector > 13]        # 13보다 큰 요소들
```

### 5. 첫 번째 시각화 (ggplot2)
```r
install.packages("ggplot2")
library(ggplot2)

# 내장 데이터셋 활용
qplot(data = mpg, x = hwy)        # 히스토그램
qplot(data = mpg, x = drv, y = hwy)  # 산점도
```

---

## 📊 Day 2: 데이터프레임과 dplyr

### 1. 데이터프레임 생성
```r
# 데이터프레임 생성
id <- c('F1', 'F2', 'F3')
name <- c('김철수', '이영희', '박민수')
age <- c(32, 28, 22)
isMarried <- c(TRUE, TRUE, FALSE)

df <- data.frame(id, name, age, isMarried, stringsAsFactors=FALSE)
```

### 2. dplyr 패키지 활용
```r
install.packages("dplyr")
library(dplyr)

# 데이터 조작
df_new <- rename(df_raw, v2 = var2)    # 변수명 변경
df$var_sum <- df$var1 + df$var2        # 새 변수 생성
```

### 3. 조건부 처리
```r
# ifelse 함수 활용
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
mpg$grade <- ifelse(mpg$total >= 30, "A", 
                   ifelse(mpg$total >= 20, "B", "C"))
```

### 4. 데이터 필터링과 정렬
```r
# 필터링
exam %>% filter(class == 1)
exam %>% filter(class == 1 & english > 90)
exam %>% filter(class %in% c(1, 3, 5))

# 정렬
exam %>% arrange(math)          # 오름차순
exam %>% arrange(desc(math))    # 내림차순

# 변수 선택
exam %>% select(math, english, class)
exam %>% select(-math)          # math 제외
```

---

## 📈 Day 3: 데이터 시각화

### 1. 기본 plot 함수
```r
# 기본 플롯
plot(mtcars$mpg, mtcars$disp)
plot(mpg ~ disp, data = mtcars)

# 그래프 옵션
plot(mpg ~ disp, data = mtcars,
     pch = 21, col = "black", bg = mtcars$am + 2,
     main = "연비와 배기량", xlab = "배기량", ylab = "연비")
```

### 2. 차트 종류별 시각화
```r
# 파이차트
bloodType <- c('A','B','A','AB','O','A','O','B')
pie(table(bloodType), 
    labels = c("A형","AB형","B형","O형"),
    col = heat.colors(4))

# 막대차트
barplot(table(bloodType),
        names.arg = c("A형", "AB형", "B형", "O형"),
        col = heat.colors(4))

# 히스토그램
hist(mpg$total)
```

### 3. ggplot2 심화
```r
# 기본 문법
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

# 색상과 모양 지정
ggplot(data = mpg, aes(x = displ, y = hwy, color = class)) + 
  geom_point()

# 막대차트
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + 
  geom_col()

# 테마 적용
ggplot(...) + theme_minimal()
```

---

## 🎯 Day 4: 고급 시각화

### 1. 다양한 geom 함수들
```r
# 산점도 + 추세선
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth(method = "lm")

# 막대차트 옵션
ggplot(data = mtcars) +
  geom_bar(aes(x = cyl, fill = as.factor(am)), 
           position = "dodge")  # 나란히 배치
```

### 2. 그래프 꾸미기
```r
# 제목과 축 라벨
ggplot(data = mtcars, aes(x = hp, y = mpg)) + 
  geom_point() + 
  labs(x = "HP(마력)", y = "MPG(연비)", 
       title = "HP와 MPG의 관계")

# 범례와 색상
ggplot(classCovDF, aes(x = bloodType, y = Freq)) + 
  geom_col(aes(fill = gender)) +
  labs(fill = "성별")
```

### 3. Treemap 시각화
```r
install.packages("treemap")
library(treemap)

treemap(sales_df, 
        vSize = "saleAmt", 
        index = c("product", "region"), 
        title = "A기업 판매현황")
```

---

## 🧹 Day 5: 데이터 전처리

### 1. 결측치(NA) 처리
```r
# 결측치 확인
is.na(df)
table(is.na(df$score))

# 결측치 제거
df %>% filter(!is.na(score))
na.omit(df)  # 모든 변수의 결측치 제거

# 결측치 포함하여 계산
mean(df$score, na.rm = T)
```

### 2. 이상치(Outlier) 처리
```r
# 박스플롯으로 이상치 확인
boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats  # 이상치 경계값 확인

# 이상치를 NA로 처리
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)

# 조건에 따른 이상치 처리
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)
```

---

## 🤖 Day 5: 머신러닝 기초

### 1. 선형회귀분석
```r
# 단순선형회귀
lm_result <- lm(formula = dist ~ speed, data = cars)
summary(lm_result)

# 회귀선 그리기
plot(cars$speed, cars$dist)
abline(lm_result)

# 예측
speed <- c(50, 60, 70, 80, 90, 100)
df_input <- data.frame(speed)
predict(lm_result, df_input)

# 구간 추정
predict(lm_result, df_input, interval = "confidence", level = 0.95)
```

### 2. 의사결정트리
```r
install.packages("rpart")
install.packages("rpart.plot")
library(rpart)
library(rpart.plot)

# 데이터 분할
library(caret)
iris_row_idx <- createDataPartition(iris$Species, p = 0.8, list = FALSE)
iris_train <- iris[iris_row_idx, ]
iris_test <- iris[-iris_row_idx, ]

# 모델 훈련
iris_rpart <- rpart(Species ~ ., data = iris_train, 
                   control = rpart.control(minsplit = 2))

# 트리 시각화
rpart.plot(iris_rpart)

# 예측 및 평가
predict_result <- predict(iris_rpart, iris_test, type = "class")
confusionMatrix(predict_result, iris_test$Species)
```

---

## 📋 주요 함수 정리

### 데이터 구조 확인
- `str()`: 데이터 구조 확인
- `summary()`: 기초통계량
- `head()`, `tail()`: 앞/뒤 6행 확인
- `dim()`: 차원 확인

### 통계 함수
- `mean()`, `median()`: 평균, 중위수
- `min()`, `max()`: 최솟값, 최댓값
- `sum()`: 합계
- `cor()`: 상관계수

### 유용한 패키지
- **dplyr**: 데이터 조작
- **ggplot2**: 시각화
- **caret**: 머신러닝
- **rpart**: 의사결정트리
- **treemap**: 트리맵 시각화

---

## 💡 학습 팁

1. **단계별 학습**: 기본 문법 → 데이터 조작 → 시각화 → 분석 순서로 진행
2. **실습 중심**: 예제 코드를 직접 실행해보며 학습
3. **데이터셋 활용**: `mtcars`, `iris`, `mpg` 등 내장 데이터셋으로 연습
4. **패키지 활용**: tidyverse 생태계 패키지들을 적극 활용
5. **에러 해결**: 에러 메시지를 주의 깊게 읽고 구글링으로 해결법 찾기

---

## 📚 추가 학습 자료

- R 공식 문서: https://cran.r-project.org/
- ggplot2 치트시트: https://rstudio.com/resources/cheatsheets/
- dplyr 치트시트: https://rstudio.com/resources/cheatsheets/
- R 커뮤니티: https://community.rstudio.com/

이 정리 자료를 바탕으로 R 프로그래밍을 체계적으로 학습하실 수 있습니다! 🚀