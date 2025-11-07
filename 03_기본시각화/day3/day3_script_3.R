library(ggplot2)

# 그래프 공간 만들기
ggplot(data=mpg, aes(x=displ, y=hwy))

# 그래프 추가
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point()

# 축의 범위 설정
ggplot(data=mpg, aes(x=displ, y=hwy)) + geom_point() + xlim(3,6)

# Q1.
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()

# Q2.
ggplot(data = midwest, aes(x = poptotal, y = popasian)) + 
  geom_point() +
  xlim(0, 50000) + 
  ylim(0, 1000)


# Q3