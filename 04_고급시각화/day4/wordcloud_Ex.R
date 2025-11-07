#=============================================================
#워드 클라우드
#=============================================================

# https://developers.naver.com
# [서비스 API] --> [검색] --> 오픈 API 이용 신청(네이버 로그인 필수)

# 애플리케이션 이름 --> R 테스트
# 비로그인 오픈 API 서비스 환경 --> [환경추가]에서 [WEB 설정] 선택
# 사용 API는 그대로 둔다

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

# Client ID 설정
clientId <- "tLGBFjnRy1810bC8GPVU"

# Client Secret 설정
clientSecret <- "g6G58StAox"

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
