#결측치 표기 - 대문자 NA
df <- data.frame(gender = c("M", "F", NA, "M", "F"),  
                    score = c(5, 4, 3, 4, NA))
df

is.na(df)	# 결측치 확인  table(is.na(df))		# 결측치 빈도 출력

#변수별로 결측치 확인하기
table(is.na(df$gender))	# gender 결측치 빈도 출력  
table(is.na(df$score))	# score 결측치 빈도 출력

#결측치 포함된 상태로 분석  
mean(df$score)		# 평균 산출  
sum(df$score)	# 합계 산출

#결측치 행 제거하기  
library(dplyr) # dplyr 패키지 로드
df %>% filter(is.na(score))	# score가 NA인 데이터만 출력

df %>% filter(!is.na(score))	# score 결측치 제거  
#결측치 제외한 데이터로 분석하기
df_perfect  <- df %>% filter(!is.na(score))	# score 결측치 제거  
df_perfect

# score, gender 결측치 제외
df_perfect <- df %>% filter(!is.na(score) & !is.na(gender))  
df_perfect

#결측치가 하나라도 있으면 제거하기
df_perfect1 <- na.omit(df)	# 모든 변수에 결측치 없는 데이터 추출  
mean(df_perfect1$score, na.rm = T)
mean(df$score, na.rm = T)

#이상치(outlier) 제거
outlier <- data.frame(gender = c(1, 2, 1, 3, 2, 1),
score = c(5, 4, 3, 4, 2, 6))
outlier

#이상치 확인하기  table(outlier$score)

#결측 처리하기 - gennder(3이면 NA 할당)
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)
outlier

#이상치 확인하기  
table(outlier$gender)  
table(outlier$score)

#결측 처리하기 - gender  
#gender가 3이면 NA 할당
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)
outlier

#결측 처리하기 - score
# score가 1~5 아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)  
outlier

#결측치 제외하고 분석  outlier %>%
filter(!is.na(gender) & !is.na(score)) %>%  
group_by(gender) %>%  
summarise(mean_score = mean(score))

#이상치 확인하기  
table(outlier$gender)  
table(outlier$score)

#결측 처리하기 - gender  
#gender가 3이면 NA 할당
outlier$gender <- ifelse(outlier$gender == 3, NA, outlier$gender)
outlier

#결측 처리하기 - score
# score가 1~5 아니면 NA 할당
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)  
outlier

#결측치 제외하고 분석  outlier %>%
filter(!is.na(gender) & !is.na(score)) %>%  
group_by(gender) %>%  
summarise(mean_score = mean(score))

#이상치 제거하기  #상자그림 생성
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

#상자그림 통계치 출력  boxplot(mpg$hwy)
boxplot(mpg$hwy)$stats	# 상자그림 통계치 출력  boxplot(mpg$hwy)$stats[5,]

#결측 처리하기
# 12~37 벗어나면 NA 할당
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)  
table(is.na(mpg$hwy))

#결측치 제외하고 분석하기  mpg %>%
group_by(drv) %>%
summarise(mean_hwy = mean(hwy, na.rm = T))
