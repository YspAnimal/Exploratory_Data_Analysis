library(nlme)
library(lattice)
xyplot(weight ~ Time | Diet, BodyWeight)


library(ggplot2)
qplot(votes, rating, data = movies)

library(datasets)
data(airquality)
qplot(Wind, Ozone, data = airquality, facets = . ~ factor(Month))

airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)

qplot(Wind, Ozone, data = airquality, geom = "smooth")
qplot(Wind, Ozone, data = airquality)

library(ggplot2)
g <- ggplot(movies, aes(votes, rating))
print(g)