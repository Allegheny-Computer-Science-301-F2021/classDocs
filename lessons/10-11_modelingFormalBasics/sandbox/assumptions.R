# Assumptions of multivariate regression


# First, let's use a normal distribution generator to see what a normal distribution looks like when plotted.
# See more examples at link: https://www.tutorialspoint.com/r/r_normal_distribution.htm


rm(list = ls()) # clear out the variables from memory to make a clean execution of the code.

# If you want to remove all previous plots and clear the console, run the following two lines.
graphics.off() # clear out all plots from previous work.

cat("\014") # clear the console

library(tidyverse)
library(tibble)

# Create a dataset of 500 randomly (but normalized distributed) numbers. 
ynorm <- rnorm(500)

# Plot a histogram of ynorm
hist(ynorm, main = "Normal Distribution")

# gimme one randomly picked number. We will use this code below to add randomness to our dataset.
runif(1)

# create a dataset to play with
dat <- tibble(num = 1:length(ynorm), 
              vals1 = c(ynorm),
              vals2 = c(vals1 *runif(1)))

# plot the random dataset values
ggplot(data = dat,
       mapping = aes(x = num, y = vals1 )) + 
  geom_point() +
  geom_smooth() +
  labs(x = "Nums") + 
  labs(y = "Normalized Magnitudes")


### Residuals
#The residual data of the simple linear regression model is the difference between the observed data of the dependent variable y and the fitted values ŷ.


# create a dataset to play with (same dataset from above)
dat <- tibble(num = 1:length(ynorm), 
              vals1 = c(ynorm),
              vals2 = c(vals1 *runif(1)))


# make a *perfect* simple linear model with one indep variable
mod <- lm(data = dat, vals1 ~ vals2)

#get a read-out of the model to check the p-value.
summary(mod)


# make a dataset of only the residuals
mod_residuals <- resid(mod)

# get a readout
summary(mod_residuals)

plot(mod_residuals)

#Standardized Residual
#The standardized residual is the residual divided by its standard deviation.

mod_stand_residuals <- rstandard(mod)
summary(mod_stand_residuals)
plot(mod_stand_residuals)



# Multicollinearity problems :-(
# note the vals1 and vals2 columns in the dataset are very similar to each other.

# create a dataset to play with

dat <- tibble(num = 1:length(ynorm), 
              vals1 = c(ynorm),
              vals2 = c(vals1 *runif(1)))


# create a model with vals1 and vals2 which are similar
mod <- lm(data = dat, num ~ vals1+vals2)
summary(mod)




# Overcoming Multicollinearity

# Create two samples of 500 numbers which are normally distributed.
ynorm1 <- rnorm(500)
ynorm2 <- rnorm(500)

# place these randomly created subsets into a dataset to work with it
dat <- tibble(num = 1:length(ynorm1), 
              vals1 = c(ynorm1),
              vals2 = c(ynorm2))

# Create a linear model with two independent variables (which are also independent from each other!)
mod <- lm(data = dat, num ~ vals1 + vals2)

# Likely still to be a bad model. Can you say why?

summary(mod)


