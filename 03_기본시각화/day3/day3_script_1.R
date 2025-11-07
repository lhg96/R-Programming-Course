# 하위 6개 행 출력
tail(mtcars)

# mtcars plot
plot(mtcars)

# 특정 좌표 plot
plot(1,2)
plot(c(1,2), c(4,5))

# mpg~disp plot
plot(mpg~disp, data=mtcars)

# mpg~am plot
plot(mpg~am,data=mtcars)

# 범주형 데이터로 변환 : factor(am)
plot(mpg~ factor(am),data=mtcars)

# y~x | a 그래프
coplot(mpg~disp | factor(am), data=mtcars)

# mfrow, points, lines, both
par(mfrow=c(2,2))
plot(1:10)
plot(1:10, type="p")
plot(1:10, type="l")
plot(1:10, type="b")

# 
par(mfrow=c(1,1))
x=rep(1:5,each=5);x
y=rep(5:1,5);y

# no plotting
plot(1:5,type="n",xlim=c(0,7.5),ylim=c(0,5.5))

# default pch=1은 속이 빈 원모양, default cex=1 의 상대적 크기
points(x,y,pch=1:25,cex=2)

# 플롯 영역의 좌표에 1~25 출력
text(x-0.5,y,labels=as.character(1:25),cex=1.5)

# A~E 출력(32:127은 ascii)
points(rep(6,5),5:1,pch=65:69, cex=2)

# A~E ascii 출력
text(rep(6,5)-0.5,5:1,labels=as.character(65:69),cex=1.5)

# 특정 문자 출력
pchs=c("&","z","M","F","가")
points(rep(7,5),5:1,pch=pchs,cex=2,family="AppleGothic")
text(rep(7,5)-0.5,5:1,labels=pchs,cex=1.5,family="AppleGothic")

# y~x graph-1
plot(mpg~disp,data=mtcars)

# y~x graph-2
plot(mpg~disp,data=mtcars,pch=21,col="black",bg=mtcars$am+2,cex=1.2,
     main="연비와 배기량",
     xlab="배기량(cu.in)",ylab="연비(mile per gallon)",
     xlim=c(0,500),ylim=c(0,40),family="AppleGothic")

# R low level graph : 기존 그래프에 점, 직선, 다각형, 범례 등 추가
legend("topright",legend=c("automatic","manual"),pch=21,col="black",pt.bg=2:3,
       cex=1.2)
text(100,10,"피타고라스의 정리",family="AppleGothic")
text(100,7,labels=expression(italic(c^2==a^2+b^2)))
polygon(c(200,300,300),c(5,10,5))
polygon(c(290,290,300,300),c(5,6,6,5))
text(240,8.2,"c")
text(260,4,"a")
text(320,7.5,"b")
abline(h=20,col="green")
abline(v=400,col="blue")
out=lm(mpg~disp,data=mtcars)
abline(out,col="red",lwd=2,lty="dotted")
arrows(200,30,300,35,angle=30)
title(sub="subtitle")
mtext(side=1,line=2,"mtext,side=1,line=2")
mtext(side=2,line=2,"mtext,side=2,line=2")
mtext(side=3,line=0.5,"mtext,side=3,line=0.5")

# 
plot(sin,-pi,pi,ylab="y")
plot(cos,-pi,pi,add=T,lty="dotted",col="red")
legend(0,-0.5,legend=c("sin","cos"),lty=1:2,col=1:2)

F = function(x,a) {1/(1+exp(-a-x))}
curve(F(x,-1),col=1,xlim=c(-5,5),ylim=c(0,1),ylab="f(x)")
par(new=TRUE)
curve(F(x,1),col=2,xlim=c(-5,5),ylim=c(0,1),ylab="",axes=FALSE,lty=2)
title(main=expression(f(x)==frac(1,1+exp(-a-x))))
legend(2,0.4,legend=c("a=-1","a=1"),lty=1:2,col=1:2)
