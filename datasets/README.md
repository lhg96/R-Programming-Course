# 📊 Datasets

## 📁 파일 설명
이 폴더에는 R 학습 과정에서 사용된 예제 데이터셋들이 포함되어 있습니다.

### 📄 파일 목록

#### `csv_exam.csv`
- **설명**: 학생들의 시험 성적 데이터
- **용도**: dplyr 패키지 실습, 데이터 조작 연습
- **주요 변수**: 
  - class: 반
  - math: 수학 점수
  - english: 영어 점수
  - science: 과학 점수

#### `df_fruit.csv`
- **설명**: 과일 관련 데이터
- **용도**: 데이터프레임 조작 실습
- **특징**: 간단한 구조의 예제 데이터

#### `excel_exam.xlsx`
- **설명**: Excel 형태의 시험 성적 데이터
- **용도**: Excel 파일 읽기 실습 (`readxl` 패키지)
- **특징**: csv_exam.csv와 유사한 구조

### 📂 Day별 데이터셋
각 Day 폴더에도 해당 학습에 특화된 추가 데이터셋이 포함되어 있습니다:
- **Day 3**: `boodType.csv`, `sales_df.csv` (시각화 실습용)

## 🔧 데이터 읽기 예제
```r
# CSV 파일 읽기
exam_data <- read.csv("datasets/csv_exam.csv")

# Excel 파일 읽기
library(readxl)
excel_data <- read_excel("datasets/excel_exam.xlsx")

# 데이터 구조 확인
str(exam_data)
head(exam_data)
```

## 💡 활용 팁
1. 각 데이터셋은 특정 학습 목표에 맞게 설계되어 있습니다
2. 실습 전에 `str()`, `summary()` 함수로 데이터 구조를 파악하세요
3. 결측치나 이상치가 포함된 데이터도 있어 전처리 연습에 활용할 수 있습니다