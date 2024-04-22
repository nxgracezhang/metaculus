library(ggplot2)

xbar <- mean(all$Tornado)
s <- sd(all$Tornado)

#boxplot
ggplot(all, aes(x = "", y = Tornado)) +
  stat_boxplot(geom = "errorbar") +
  geom_boxplot() +
  ggtitle("Boxplot of Tornado 2014-2023 All Months") +
  stat_summary(fun.y = mean, col = "black", geom = "point", size = 3) 

#qq plot
ggplot(all, aes(sample = Tornado)) +
  stat_qq() +
  geom_abline(slope = s, intercept = xbar) +
  ggtitle("QQ Plot of Tornado 2014-2023 All Months")

#histogram
ggplot(all, aes(Tornado)) +
  geom_histogram(aes(y = ..density..),
                 bins = 20,
                 fill = "grey", col = "black") +
  geom_density(col = "red", lwd = 1) +
  stat_function(fun = dnorm, args = list(mean = xbar, sd = s),
                col="blue", lwd = 1) +
  ggtitle("Histogram of Tornado 2014-2023 All Months") +
  xlab("Tornada") +
  ylab("Proportion")

#values
print(mean(all$Tornado))
print(median(all$Tornado))
print(sd(all$Tornado))
print(quantile(all$Tornado))
