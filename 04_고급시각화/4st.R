library(ggplot2)
data(mpg)
data("mtcars")
mtcars


ggplot(data=mpg)  +
  geom_point(mapping = aes(x=displ, y = hwy))

ggplot(data = mtcars) +
  geom_point(mapping = aes(x = mpg, y = wt))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data=mpg)+ 
  geom_point(mapping = aes(x=displ, y=hwy, alpha = class))

ggplot(mpg, aes(x=displ, y = hwy))+
  geom_smooth()

ggplot(mpg, aes(x=displ, y = hwy))+
  geom_smooth(method = "lm")

ggplot(mpg, aes(x = displ, y =hwy))+
  geom_point() + geom_smooth(method ="lm")


ggplot(mpg, aes(x=displ, y = hwy))+
  geom_point() +  geom_smooth(aes(linetype = drv))

ggplot(mpg, aes(x=displ, y = hwy))+
  geom_point() +  geom_smooth(aes(linetype = drv), method = "lm")

ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = cut))

ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = clarity))

ggplot(diamonds) +
  geom_bar(aes(x = cut, fill = clarity), position = "fill")
 
install.packages("forigne")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss(file="Koweps_hpc10_2015_beta1.sav", to.data.frame = T)
View(head(raw_welfare))
dim(raw_welfare)

welfare <- raw_welfare

View(head(welfare))
summary(welfare)
str(welfare)
names(welfare)

welfare <- dplyr::rename(welfare,
                         sex = h10_g3, # 성별
                         birth = h10_g4, # 태어난 연도
                         marriage = h10_g10, # 혼인 상태
                         religion = h10_g11, # 종교
                         income = p1002_8aq1, # 월급
                         code_job = h10_eco9, # 직업 코드
                         code_region = h10_reg7 # 지역 코드
)

head(welfare$sex,5)


welfare_subset <- subset(
  welfare,
  select = c(sex, birth, marriage, religion, income, code_job, code_region)
)
class(welfare$sex)
table(welfare$sex)
qplot(welfare$sex)

class(welfare$income)
summary(welfare$income)

qplot(welfare$income)
qplot(welfare$income) + xlim(0,1000)


welfare$sex <-ifelse(welfare$sex == 9, NA, welfare$sex)


welfare$sex <-  ifelse(welfare$sex == 1, "male", "female")
welfare$sex

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


class(welfare$income)
summary(welfare$income)

qplot(welfare$income) + 
  xlim(0,1000)

head(welfare$sex, 5)

qplot(welfare$income)+ # + 기호는 동일 줄에 위치해야함 다음음 줄로 내릴수 없음
  xlim(0,1000)
welfare$income <-  ifelse(welfare$income %in% c(0, 9999), NA, welfare$income)
table(is.na(welfare$income))

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


dim(sex_income_dat)
View(sex_income_dat)

qplot(sex_income_dat$sex)
t.test(data = sex_income_dat, income~sex, var.equal=T)

pnorm(800,mean = 600, sd=100)
pnorm(800,mean = 600, sd=100, lower.tail = F)
pnorm(65, mean = 60, sd=5)

# 203.18g을 초과할 확률
pnorm(203.18, mean=300, sd=50, lower.tail=FALSE)

# 302.9g을 초과할 확률
pnorm(302.9, mean=300, sd=50, lower.tail=FALSE)

# 203.18g ~ 302.9g 사이일 확률 = 203.18g 초과확률 - 302.9g 초과 확률
pnorm(203.18, mean=300, sd=50, lower.tail=FALSE) - pnorm(302.9, mean=300, sd=50, lower.tail=FALSE)


# A과수원의 사과 중 상위 10%인 지점의 무게
qnorm(0.1, mean=300, sd=50, lower.tail=FALSE)

# A과수원의 사과 중 하위 10%인 지점의 무게
qnorm(0.1, mean=300, sd=50, lower.tail=T)

#-------------------------------------------------------------

# A반 수학 성적
Aclass <- c(10, 10, 100, 100)

# A반 수학 성적 평균
mean(Aclass)

# A반 수학 성적 히스토그램
hist(Aclass, breaks=10)


# Aclass Samples Mean 구하기
# 1:20은 1~20까지 연속된 수로서 sapply 내의 함수를 20번 반복적으로 실행하기 위해 설정함
asm<-sapply(1:20, function(i) mean(
  sample(Aclass, 2, replace=F)))
asm
mean(asm)
hist(asm)


asm2<-sapply(1:20, function(i) mean(
  sample(asm, 2, replace=F)))
mean(asm2)
hist(asm2)


# A반 수학 성적 생성(총 300개, 10점/50점/100점 각 100개)
Aclass2 <- c(rep(10, 100), rep(50, 100), rep(100, 100))
# A반의 수학 성적 평균
mean(Aclass2)
# A반의 수학 성적 히스토그램
hist(Aclass2)
# 2행 2열로 그래프 한번에 그리기 위해 설정
par(mfrow=c(2, 2))

# 2씩 뽑아 (표본 크기 2) 10,000번 추출 후 평균
asm2<-sapply(1:10000, function(i) mean(sample(Aclass2, 2, replace=F)))
hist(asm2, main="표본크기 2")

# 30씩 뽑아 (표본 크기 2) 10,000번 추출 후 평균
asm2<-sapply(1:10000, function(i) mean(sample(Aclass2, 30, replace=F)))
hist(asm2, main="표본크기 30")

# 50씩 뽑아 (표본 크기 2) 10,000번 추출 후 평균
asm2<-sapply(1:10000, function(i) mean(sample(Aclass2, 50, replace=F)))
hist(asm2, main="표본크기 50")

# 80씩 뽑아 (표본 크기 80) 10,000번 추출 후 평균
asm2<-sapply(1:10000, function(i) mean(sample(Aclass2, 80, replace=F)))
hist(asm2, main="표본크기 80")


# 집합 만들기
groupA <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 0)

# 1번째 수행
sample(groupA, 4)

# 2번째 수행
sample(groupA, 4)

# 3번째 수행
sample(groupA, 4)


# 1번째 수행 - seed 번호 1234
set.seed(1234)
sample(groupA, 4)

# 2번째 수행 - seed 번호 1234
set.seed(1234)
sample(groupA, 4)

#=============================================================
# 가설
#=============================================================

# 대립가설(alternative hypothesis) : 가설 검정에서 연구자의 주장이 담긴 진술
# 귀무가설(null hypothesis) : 가설 검정에서 연구자의 주장에 대한 부정 진술

#=============================================================
# p-value
#=============================================================

# 귀무가설이 참이라는 가정 아래 얻은 통계량이 귀무가설을 얼마나 지지하는지를 나타낸 확률

summary(lm(cars$speed~cars$dist))

# 1 기본 URL
urlStr <- "https://openapi.naver.com/v1/search/blog.xml?"



# 2 검색어 설정 및 UTF-8 URL 인코딩
searchString <- "query=코타키나발루"

# 2.1 UTF-8 인코딩
searchString <- iconv(searchString, to= "UTF-8")

# 2.2 URL 인코딩
searchString <-URLencode(searchString)

# 2.3 인코딩된 내역 확인
searchString

# 3. 나머지 요청변수 설정(각 요청변수는 &로 연결)
# 조회 개수 100개, 시작 페이지 1, 유사도순 정렬
etcString <- "&display=100&start=1&sort=sim"

# 4. URL 조립
reqUrl <- paste(urlStr, searchString, etcString, sep="")

# 5. 조립된 URL 확인
reqUrl

#-------------------------------------------------------------

# 최초 실행 시 패키지 설치
install.packages("httr")

# 패키지 로드
library(httr)
#CfbtA1KeEblCEjfOjF9m
#6dTnYtvMJ9
# Client ID 설정
clientId <- "CfbtA1KeEblCEjfOjF9m"

# Client Secret 설정
clientSecret <- "6dTnYtvMJ9"

# GET 함수 호출(인증정보는 add_headers에 담아 함께 전송)
apiResult <- GET(reqUrl, add_headers("X-Naver-Client-Id"=clientId, "X-Naver-Client-Secret"=clientSecret))

# 호출 결과 조회(응답코드(status)가 200이면 정상)
apiResult

# Open API의 결과 구조 확인
str(apiResult)

#-------------------------------------------------------------

# 응답 결과 내용 확인
apiResult$content

# content 요소 확인
str(apiResult$content)

#-------------------------------------------------------------

# raw 형을 문자로 변환
result <- rawToChar(apiResult$content)

# 변환 결과 확인(한글이 깨져 있음)
result

# UTF-8 인코딩
Encoding(result) <- "UTF-8"

# 변환 결과 확인(한글이 정상적으로 출력됨)
result

#-------------------------------------------------------------

# ABC를 ***로 변환
gsub("ABC", "***", "ABCabcABC")

# 대소문자를 무시하고 변환
gsub("ABC", "***", "ABCabcABC" , ignore.case=T)

# 벡터 문자열 치환
x <- c("ABCabcABC", "abcABCabc")
gsub("ABC", "***", x)

#-------------------------------------------------------------

# b와 n 사이에 문자 1개가 있는 패턴은 ***로 치환
gsub("b.n", "***", "i love banana")

# b 이후 문자가 0개 이상 있고 a로 끝나는 패턴은 ***로 치환
gsub("b.*a", "***", "i love banana")

# ba와 na는 ***로 치환
gsub("[bn]a", "***", "i love banana")

# 핸드폰 전화번호 패턴: 010-숫자4개-숫자4개
gsub("010-[0-9]{4}-[0-9]{4}", "010-****-****", "내 폰 번호는 010-9123-0000")

# 핸드폰 전화번호 패턴: 010-숫자4개-숫자4개
gsub("010-\\d{4}-\\d{4}", "010-****-****", "내 폰 번호는 010-9123-0000")

#-------------------------------------------------------------

# 변경 전 검색 결과
result

# 검색 결과를 변수에 저장
refinedStr <- result

# XML 태그를 공란으로 치환
refinedStr <- gsub("<(\\/?)(\\w ???+)*([^<>]*)>", " ", refinedStr)

# 단락을 표현하는 불필요한 문자를 공란으로 치환
refinedStr <- gsub("[[:punct:]]", " ", refinedStr)

# 영어 소문자를 공란으로 치환
refinedStr <- gsub("[a-z]", " ", refinedStr)

# 숫자를 공란으로 치환
refinedStr <- gsub("[0-9]", " ", refinedStr)

# 여러 공란은 한 개의 공란으로 변경
refinedStr <- gsub(" +", " ", refinedStr)

# 변경 후의 검색 결과
refinedStr

#-------------------------------------------------------------
#정상잘 되는 버젼
#https://r-pyomega.tistory.com/12
install.packages("multilinguer")
library(multilinguer)
install_jdk()
install.packages(c('stringr', 'hash', 'tau', 'Sejong', 'RSQLite', 'devtools'), type = "binary")
install.packages("remotes")
remotes::install_github('haven-jeon/KoNLP', upgrade = "never", INSTALL_opts=c("--no-multiarch"))
library(KoNLP) #최종적으로 "KoNLP" 패키지를 불러옵니다


# 최초 실행 시 패키지 설치
install.packages("KoNLP")

# 패키지 로드
library(KoNLP)

# 단어 추출 테스트
extractNoun("안녕하세요 오늘은 기분 좋은 하루 입니다.")

#-------------------------------------------------------------

# 검색 문장 내 단어 추출
nouns <- extractNoun(refinedStr)

# 단어 추출 결과 확인
str(nouns)

# 추출된 단어 중 일부를 확인(앞에서부터 40개)
nouns[1:40]

#-------------------------------------------------------------

# 길이가 1인 문자를 제외
nouns <- nouns[nchar(nouns) > 1]

# 제외할 특정 단어를 정의
excluNouns <- c("코타키나발루", "얼마", "오늘", "으로", "해서", "API", "저희", "정도")

# 특정 단어를 제외
nouns <- nouns [!nouns %in% excluNouns]

# 추출된 단어 중 일부를 확인(앞에서부터 40개)
nouns[1:40]

#-------------------------------------------------------------

# 빈도수(table)를 기준으로 내림차순(decreasing=T) 정렬(sort) -> 상위 50개만 추출([1:50])
wordT <- sort(table(nouns), decreasing=T)[1:50]

# 추출 결과 확인
wordT

#-------------------------------------------------------------

# 최초 실행 시 패키지 설치
install.packages("wordcloud2")

# 패키지 로드
library(wordcloud2)

# 워드 클라우드 그리기
wordcloud2(wordT, size = 3, shape='diamond')

#-------------------------------------------------------------
# 추출한 명사 list를 문자열 벡터로 변환, 단어별 빈도표 생성
wordFreq <- table(unlist(nouns))

# 데이터 프레임으로 변환
save_word <- as.data.frame(wordFreq, stringsAsFactors = F)

# csv로 저장
write.csv(save_word, "save_word.csv")
#-------------------------------------------------------------