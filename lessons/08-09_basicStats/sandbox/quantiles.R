# date: 14 October 2021
# demo code of quantiles for simple data set

rm(list = ls()) # clear out the variables from memory to make a clean execution of the code.

# If you want to remove all previous plots and clear the console, run the following two lines.
graphics.off() # clear out all plots from previous work.

cat("\014") # clear the console



library(tidyverse)
library(tibble)

qnums  <- c(3, 6, 7, 8, 8, 10, 13, 15, 16, 20)
summary(qnums) # quick preparation of stats
quantile(qnums) # just report the quantiles

# lets make a plot to see where these quantile divisions.
mySummary <- summary(qnums) # quick preparation of stats

#define the quantile variables for 1st, 2nd and 3rd values
firstQuantile <- as.numeric(mySummary[2])
secondQuantile <- as.numeric(mySummary[3])
thirdQuantile <- as.numeric(mySummary[5])
cat(" 25%:", firstQuantile," mean:", secondQuantile, " 75%:",thirdQuantile)


#View(qnums) # OH NO! This is not a spreadsheet-like form to create a plot with ggplot(). 

# We will need to make a data frame using tibble().
qnumsDat <- tibble(num = 1:length(qnums), 
                   vals = c(qnums) )

ggplot(data = qnumsDat,
  mapping = aes(x = 1:length(qnums), y = qnums )) + 
  geom_point() +
  geom_hline(yintercept = firstQuantile, color = "red") +
  geom_hline(yintercept = secondQuantile, color = "blue") +
  geom_hline(yintercept = thirdQuantile, color = "purple") +
  geom_smooth() +
  labs(x = "Nums") + 
  labs(y = "Qnums and Quantile Divisions")

