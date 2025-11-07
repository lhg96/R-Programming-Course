library(ggplot2)

#막대형 그래프의 POSITION = "stack
args(geom_histogram)
args(geom_bar)

ggplot(data=mtcars) + 
  geom_histogram(mapping = aes(x=hp))

#data, mapping 생략 가능
ggplot(mtcars, aes(hp)) + 
  geom_histogram()

#cyl별로 가장 간단한 막대 그래프 생성
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl))

#am 변수를 fill 항목에 적용. position default = "stack"
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)))

#positon = "stack"은 값을 위로 쌓아 누적 막대 그래프를 생성
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "stack")

#position = "dodge"는 값을 옆으로 겹치지 않게 하여 그래프를 생성
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "dodge")

#100% 기준 누적 막대 그래프 생성. 세로 축 count 값은 1을 기준으로 생성
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "fill")

#위치 조정하지 않고 as.factor(am)은 0과 1의 level을 기준으로 level=0을 그리고 그 위에 level=1을 그렸다
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "identity")

#값들이 겹치지 않도록 값들을 약간씩 움직이는 것을 의미. 범주형 자료에는 유용하지 않음
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "jitter")


#as.factor(cyl) 값이 8인 경우에는 mpg 값들이 겹침
ggplot(data=mtcars) +
  geom_point(mapping = aes(x=as.factor(cyl), y=mpg))

#as.factor(cyl)별 mpg 값이 겹치지 않도록
ggplot(data=mtcars) +
  geom_point(mapping = aes(x=as.factor(cyl), y=mpg), position = "jitter")


#coord_flip() : x축 <---> y축 바꾸기. default는 세로막대
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=factor(am)), position="dodge")

ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=factor(am)), position="dodge") + 
  coord_flip()

#coord_polar() : 극좌표계 이용. 원점을 기준으로 거리 방향을 정하는 극좌표계로 그래프를 생성
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(cyl)), position="dodge") + 
  coord_polar()

#facet()
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
         geom_point()

#facet_wrap(~cyl) : cyl 별로 sub그래프를 그려줌
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  facet_wrap(~cyl)

#labeller=label_both 옵션을 적용하면 facet 처리되는 변수와 레벨 값 표시
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  facet_wrap(~cyl, labeller = label_both)

#첫번째 변수의 첫번째 레벨 안에서 두번째 변수의 레벨별 순서로 sub 그래프 작성
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  facet_wrap(~cyl+am, labeller = label_both)

#nrow, ncol옵션
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  facet_wrap(~cyl+am, labeller=label_both, nrow = 3)

#facet_grid() : ~ 좌/우 변수를 각각 행/열로 나누어 2차원으로 sub그래프 작성
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  facet_grid(am~cyl)

#facet 처리되는 변수 및 그 레벨 값이 표시 : labeller=label_both
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  facet_grid(am~cyl, labeller=label_both)

#첫번째 변수의 첫번째 레벨 안에서 두번째 변수의 레벨별 순서로 sub 그래프 작성
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  facet_grid(am~cyl+gear, labeller=label_both)

#nrow 옶션은 error
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  facet_grid(am~cyl+gear, labeller=label_both, nrow=4)

#facet_wrap()과 같이 한쪽방향으로 그리려면 .(마침표) 활용
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  facet_grid(.~cyl+am, labeller=label_both)


#축, 그래프 제목 설정 방법1
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  labs(x="HP(마력)",y="MPG(연비)", title="HP와 MPG의 관계1")

#축, 그래프 제목 설정 방법2
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  ggtitle("HP과 MPG의 관계1") + 
  xlab("HP(마력)") + 
  ylab("MPG(연비)")

#theme() 적용
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  ggtitle("HP과 MPG의 관계2") + 
  xlab("HP(마력)") + 
  ylab("MPG(연비)") + 
  theme(plot.title = element_text(size=20, 
                                  color="red", 
                                  hjust=0.5))

theme_set(theme_classic())
theme_set(theme_grey())

ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point() + 
  ggtitle("HP과 MPG의 관계3") + 
  xlab("HP(마력)") + 
  ylab("MPG(연비)") + 
  theme(plot.title = element_text(size=20, 
                                  color="red", 
                                  hjust=0.5), 
        axis.title.x = element_text(size=25, 
                                    color="blue", 
                                    hjust=1), 
        axis.title.y = element_text(size=15,
                                    color="green",
                                    hjust=0))

#모든 제목요소들을 한번에 변경하려면 title
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point(aes(color=as.factor(am))) + 
  ggtitle("HP과 MPG의 관계4") + 
  xlab("HP(마력)") + 
  ylab("MPG(연비)") + 
  theme(title = element_text(color="orange", hjust=1, size=20))

#모든 텍스트 요소들의 설정을 한번에 변경하려면  text
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point(aes(color=as.factor(am))) + 
  ggtitle("HP과 MPG의 관계5") + 
  xlab("HP(마력)") + 
  ylab("MPG(연비)") + 
  theme(text = element_text(color="orange", hjust=1, size=20))

#default legend position
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "dodge")

#bottom
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "dodge") + 
  theme(legend.position = "bottom")

#legend none
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "dodge") + 
  theme(legend.position = "bottom") + 
  guides(fill="none")

#범례 및 그래프 색 변경: scale_color_manual() , scale_fill_manual()
#scale_color_manual()은 점 및 선 그래프, scale_fill_manual()은 막대 그래프 등에 적용됨
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "dodge") + 
  theme(legend.position = "bottom") + 
  scale_fill_manual(values = c("red","blue"),
                    name = ("범례"),
                    breaks = c(0,1),
                    labels = c("Auto","Manual"))
#범례의 제목 및 항목값만 변경 : scale_fill_discrete() 
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "dodge") + 
  theme(legend.position = "bottom") + 
  scale_fill_discrete(name="범례",
                      labels=c("Auto","Manual"))
#labs()
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)), position = "dodge") + 
  theme(legend.position = "bottom") +
  labs(x = "cyl(실린더)",
       y = "count(빈도)",
       title = "cyl vs count 분석",
       subtitle = "막대그래프",
       caption = "출처 = R기초")


#label
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point(aes(color=as.factor(am)))

ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point(aes(color=as.factor(am))) +
  geom_text(aes(label=rownames(mtcars)))

#check_overlap = T : 겹치는 텍스트 레이블을 안보이도록 함
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point(aes(color=as.factor(am))) +
  geom_text(aes(label=rownames(mtcars)), check_overlap = T)

#geom_label() : 가독성 떨어질 수 있음
ggplot(data=mtcars, mapping = aes(x=hp, y=mpg)) + 
  geom_point(aes(color=as.factor(am))) +
  geom_label(aes(label=rownames(mtcars), fill=as.factor(am)))

#막대 그리프 레이블
ggplot(data=mtcars, mapping = aes(x=cyl, y=..count.., fill=as.factor(am))) + 
  geom_bar(position = "dodge",
           width=1.8) + 
  geom_text(stat = "count", 
            aes(label=..count..),
            position = position_dodge(width=1.8),
            vjust=-0.5)

