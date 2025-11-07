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



