#ggplot(data = DF, mapping = aes(x = var1, y = var2, color = var3, fill = var4)) + geom_point()
#ggplot(data = DF) + geom_point(aes(x = var1, y = var2, color = var1, fill = var2))

library(ggplot2)
data(mpg)

#Q1.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy))

#Q2.
ggplot(data = mtcars) + 
  geom_point(mapping = aes(x = mpg, y = wt))

#Q3.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = hwy, y = cyl))

#Q4.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, size = class))

#Q5.
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, shape = class))


#Q6. 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_smooth()


#Q7.
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_smooth(method = "lm")

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + geom_smooth()

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + geom_smooth(method = "lm")


#Q8.
ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + geom_smooth(aes(linetype = drv))

ggplot(mpg, aes(x = displ, y = hwy)) + 
  geom_point() + geom_smooth(aes(linetype = drv), method = "lm")

#Q9.
ggplot(mpg, aes(x = displ, y = hwy, color = drv)) + 
  geom_point() + geom_smooth()

#Q10.
ggplot(diamonds) + 
  geom_bar(aes(x = cut))

ggplot(diamonds) + 
  geom_bar(aes(x = cut, fill = cut))

#geom_bar() 대신 숫자를 세는 함수로 stat_count() 활용
ggplot(data = diamonds) + 
  stat_count(mapping = aes(x = cut, fill = cut))

ggplot(diamonds) + 
  geom_bar(aes(x = cut, fill = clarity))

ggplot(diamonds) + 
  geom_bar(aes(x = cut, fill = clarity), position = "fill")


