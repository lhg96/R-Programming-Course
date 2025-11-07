# 03_기본시각화

## 📚 학습 목표
R의 기본 plot 함수와 ggplot2를 활용하여 다양한 기본 차트를 생성할 수 있다.

## 📁 파일 구성
- `3st.R`: 세 번째 수업 코드 (기본 plot, 차트 종류)
- `day3/`: Day 3 상세 실습 파일들
  - `day3_script_1.R`: 기본 plot 함수 실습
  - `day3_script_2.R`: 차트 옵션 및 꾸미기
  - `day3_script_3.R`: ggplot2 기초
  - `day3_script_4.R`: 고급 시각화 옵션
  - `boodType.csv`: 혈액형 데이터
  - `sales_df.csv`: 판매 데이터

## 🎯 주요 학습 내용
1. **기본 plot 함수**
   - `plot()`: 산점도, 선그래프
   - `points()`, `lines()`: 요소 추가
   - 그래프 옵션: pch, cex, col, bg

2. **차트 종류**
   - **파이차트**: `pie()` 함수
   - **막대차트**: `barplot()` 함수
   - **히스토그램**: `hist()` 함수
   - **박스플롯**: `boxplot()` 함수

3. **ggplot2 기초**
   - `ggplot()` 기본 문법
   - `aes()`: 미적 요소 매핑
   - `geom_point()`: 산점도
   - `geom_col()`: 막대차트

4. **그래프 꾸미기**
   - 색상, 범례, 제목 설정
   - 테마 적용: `theme_minimal()`, `theme_classic()`

5. **특수 시각화**
   - Treemap: `treemap()` 패키지
   - 상관관계 분석 및 시각화