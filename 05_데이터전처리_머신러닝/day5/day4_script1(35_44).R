#4. 연령대 및 성별에 따른 월급 차이
#연령대 및 성별 월급 평균표 만들기 
sex_income <- welfare %>% 
  filter(!is.na(income)) %>% 
  group_by(ageg, sex) %>% 
  summarise(mean_income = mean(income))
  
sex_income

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

#5. 직업별 월급 차이  
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
