# 04_고급시각화

## 📚 학습 목표
ggplot2의 고급 기능을 활용하여 전문적이고 아름다운 시각화를 구현할 수 있다.

## 📁 파일 구성
- `4st.R`: 네 번째 수업 코드 (ggplot2 고급 기능)
- `day4/`: Day 4 상세 실습 파일들
  - `day4_script1.R`: ggplot2 기본 문법 심화
  - `day4_script2.R`: 다양한 geom 함수들
  - `day4_script3.R`: 그래프 레이아웃 및 테마
  - `day4_script4.R`: 고급 시각화 기법
  - `wordcloud_Ex.R`: 워드클라우드 실습

## 🎯 주요 학습 내용
1. **ggplot2 심화**
   - 다양한 `geom_*()` 함수들
   - `geom_smooth()`: 추세선 추가
   - `geom_histogram()`: 히스토그램
   - `geom_bar()`: 막대차트 옵션

2. **그래프 레이아웃**
   - `position` 옵션: stack, dodge, fill, jitter
   - `facet_wrap()`, `facet_grid()`: 분할 그래프
   - 다중 패널 구성

3. **색상과 스타일**
   - `color`, `fill`, `size`, `alpha` 속성
   - `scale_*()` 함수로 스케일 조정
   - 커스텀 색상 팔레트

4. **축과 제목**
   - `labs()`: 제목, 축 레이블 설정
   - `ggtitle()`, `xlab()`, `ylab()`
   - 축 범위 조정: `xlim()`, `ylim()`

5. **테마와 스타일링**
   - 내장 테마: `theme_minimal()`, `theme_classic()`
   - 커스텀 테마 생성
   - 범례 위치 및 스타일 조정

6. **고급 시각화**
   - 통계적 변환
   - 애니메이션 그래프 (gganimate)
   - 인터랙티브 그래프 (plotly)