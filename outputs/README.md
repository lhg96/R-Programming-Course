# 📈 Outputs

## 📁 폴더 설명
이 폴더에는 R 스크립트 실행 결과로 생성된 그래프, 차트, 보고서 등의 출력 파일들이 저장됩니다.

### 📄 현재 파일
- `Rplot.png`: R 시각화 실습 중 생성된 플롯 이미지

## 🎯 용도
- 시각화 결과물 저장
- 분석 보고서 출력
- 모델 결과 그래프 보관
- 발표용 차트 이미지

## 💾 출력 파일 생성 예제
```r
# 그래프를 파일로 저장
png("outputs/my_plot.png", width = 800, height = 600)
plot(mtcars$mpg, mtcars$disp)
dev.off()

# ggplot2 그래프 저장
library(ggplot2)
p <- ggplot(mtcars, aes(x = mpg, y = disp)) + geom_point()
ggsave("outputs/ggplot_example.png", p, width = 10, height = 6)

# PDF로 저장
pdf("outputs/analysis_report.pdf")
plot(cars)
hist(mtcars$mpg)
dev.off()
```

## 📋 파일 형식별 용도
- **PNG/JPEG**: 웹이나 문서에 삽입할 이미지
- **PDF**: 고품질 출력, 학술 논문용
- **SVG**: 벡터 그래픽, 확대해도 깨지지 않음
- **HTML**: 인터랙티브 그래프 (plotly 등)

## 🗂 파일 관리 팁
1. 파일명에 날짜나 버전을 포함하여 관리
2. 프로젝트별로 하위 폴더 생성
3. 정기적으로 불필요한 파일 정리
4. 중요한 결과물은 별도 백업