# Machine Learning example using the KNN (k-Nearest Neighbours) learning algorithm.
# CS301::Allegheny College::OBC
# Date: 16 November 2021
# Much of this code was stolen from ref: https://www.datacamp.com/community/tutorials/machine-learning-in-r#five



#################################################
##### # Notes on KNN: 
#################################################
# The k-nearest neighbors (KNN) algorithm is supervised machine learning algorithm for use in classification and regression problems. It is simple to use but slows with larger datasets 


# KNN works by finding the distances between a query and all the examples in the data.  It first selects the specified number examples (K) closest to the query, and then "votes" for the most frequent label (in the case of classification) or averages the labels (in the case of regression).

#Learn the theory (using Python) at ref: https://towardsdatascience.com/machine-learning-basics-with-the-k-nearest-neighbors-algorithm-6a6e71d01761






rm(list = ls()) # clear out the variables from memory to make a clean execution of the code.

# If you want to remove all previous plots and clear the console, run the following two lines.
graphics.off() # clear out all plots from previous work.

cat("\014") # clear the console



#################################################
#### Setup your libraries
#################################################

# Do you already have the necessary libraries installed? 
# Let's see using the below code.
any(grepl("tidyverse", installed.packages())) # check for "tidyverse"
# install.packages("tidyverse")
library(tidyverse)



any(grepl("class", installed.packages())) # check for "class"
# install.packages("class")
library(class)

# One requirement of KNN is that its data must be normalized. Is your iris dataset normalized?

any(grepl("car", installed.packages())) # check for "car"
# install.packages("class")
library(car)



any(grepl("gmodels", installed.packages())) # check for "gmodels"
# install.packages("gmodels")
library(gmodels)
#################################################
#### Exploratory: get to know the data set
#################################################

View(iris)

#### make a plot to see what types of correlations exist in the data
ggplot(data = iris) + geom_point(mapping = aes(x = Sepal.Length, y = Sepal.Width,color = Species ))

# note: the plot indicates a positive correlation between the petal length and the petal width for all different species that are included into the Iris data set


#################################################
#### Study the correlations of the data
#################################################


# Overall correlation `Petal.Length` and `Petal.Width`
cor(iris$Petal.Length, iris$Petal.Width)

# Return values of `iris` levels of "Species" that we are studying.
x=levels(iris$Species) 

# aggregations (i.e., groupings) by species type (i.e., "setosa","versicolor", "virginica" )

# Print "Setosa" correlation matrix
print(x[1])
cor(iris[iris$Species==x[1],1:4])

# Print Versicolor correlation matrix
print(x[2])
cor(iris[iris$Species==x[2],1:4])

# Print Virginica correlation matrix
print(x[3])
cor(iris[iris$Species==x[3],1:4])


# Return all `iris` data
iris

# Return first 5 lines of `iris`
head(iris)

# Return structure of `iris`
str(iris)

# Division of `Species` (how many data points are there for each group?)
table(iris$Species) 

# Division by percentage of `Species` (what are the percentages of each group in the larger dataset?)
# results are rounded to one decimal point using `digits`
round(prop.table(table(iris$Species)) * 100, digits = 1)



#################################################
#### Study the normalized nature of the data
#################################################


# Summary overview of `iris`
summary(iris) 
# Note: the values of all data sets start at min values which are above 0 and expand to max values that are above 1. This is not bad for this LM experiment but still not perfectly normalized... :-(


# Get a closer look at the columns: A refined summary overview (the "Petal.Width" and "Sepal.Width" columns)
summary(iris[c("Petal.Width", "Sepal.Width")])



#################################################
#### QQ-plots to view normalized struture of data
#################################################

?qqplot()
# Do the points closely follow the diagonal line?
qqPlot(iris$Sepal.Length) # good
qqPlot(iris$Sepal.Width) # good

qqPlot(iris$Petal.Length) # so-so; the diagonal line is not completely traced
qqPlot(iris$Petal.Width) # so-so; the diagonal line is not completely traced

# Another type of qqplot to try out where the points are compared to a "perfect" Student t Distribution. Note the lower-case 'q' in qqplot().

qqplot(iris$Sepal.Length, rt(300, df = 5)) # good
qqplot(iris$Sepal.Width, rt(300, df = 5)) # good

qqplot(iris$Petal.Length, rt(300, df = 5)) # so-so; the diagonal line is not completely traced
qqplot(iris$Petal.Width, rt(300, df = 5)) # so-so; the diagonal line is not completely traced



# Build your own `normalize()` function. Running data using this function ensures that this data has been normalized for the KNN experiment

makeNormalizized <- function(myCol) {
  # for each value in the inputted column (myCol), 
  #   normalizedValue 
  #       = (myCol - min(myCol)) / (max(myCol) - min(myCol)) 
  numerator <- myCol - min(myCol) 
  denominator <- max(myCol) - min(myCol)
  return (numerator/denominator)
}

# Normalize the `iris` data; apply the data to the function and place output into a dataframe to be used in the code below.
iris_norm <- as.data.frame(lapply(iris[1:4], makeNormalizized))

# Summarize `iris_norm`
summary(iris_norm)
# Note: the data has been normalized and can be seen to be spread-out between min = 0 and max = 1

View(iris_norm)

# check the normalized situation again on new normalized set.
# Do the points closely follow the diagonal line?
qqPlot(iris_norm$Sepal.Length) # good
qqPlot(iris_norm$Sepal.Width) # good

qqPlot(iris_norm$Petal.Length) # better; the diagonal line more closely the follows traced line. Values are between 0 and 1
qqPlot(iris_norm$Petal.Width) # better; the diagonal line more closely the follows traced line. Values are between 0 and 1


# Another type of qqplot to try out where the points are compared to a "perfect" Student t Distribution. Note the lower-case 'q' in qqplot().

qqplot(iris_norm$Sepal.Length, rt(300, df = 5)) # good
qqplot(iris_norm$Sepal.Width, rt(300, df = 5)) # good

qqplot(iris_norm$Petal.Length, rt(300, df = 5)) # so-so; the diagonal line is not completely traced
qqplot(iris_norm$Petal.Width, rt(300, df = 5)) # so-so; the diagonal line is not completely traced


#################################################
#### Prepare the training and test sets
#################################################

# get a random see to divide the Iris data into training and test
set.seed(1234)

# Taken Verbatim: "You use the sample() function to take a sample with a size that is set as the number of rows of the Iris data set, or 150. You sample with replacement: you choose from a vector of 2 elements and assign either 1 or 2 to the 150 rows of the Iris data set. The assignment of the elements is subject to probability weights of 0.67 and 0.33."

# Create a training set of 2/3 of the data and a test set of the remaining 1/3 of the data in Iris.  
?sample() # get a random sample
ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.67, 0.33))

# Compose training set
iris.training <- iris[ind==1, 1:4]

# Inspect training set
head(iris.training)

# Compose test set
iris.test <- iris[ind==2, 1:4]

# Inspect test set
head(iris.test)



#################################################
#### Use training set to teach "Species" type
#################################################


# Compose `iris` training labels
iris.trainLabels <- iris[ind==1,5]

# Inspect result
print(iris.trainLabels)

# Compose `iris` test labels
iris.testLabels <- iris[ind==2, 5]

# Inspect result
print(iris.testLabels)



#################################################
#### Building the KNN model for the testing set
#################################################


# Build the model
iris_pred <- knn(train = iris.training, test = iris.test, cl = iris.trainLabels, k=3)

# Inspect `iris_pred`
iris_pred



#################################################
#### Evaluating the KNN model for the testing set
#################################################


# Put `iris.testLabels` in a data frame
irisTestLabels <- data.frame(iris.testLabels)

# Merge `iris_pred` and `iris.testLabels` 
merge <- data.frame(iris_pred, iris.testLabels)

# Specify column names for `merge`
names(merge) <- c("Predicted Species", "Observed Species")

# Inspect `merge` (i.e., see where "Predicted Species" == "Observed Species")
merge




#################################################
#### Checking performance
#################################################


# Taken Verbatim:  
# We make a cross tabulation or a contingency table. This type of table is often used to understand the relationship between two variables. In this case, you want to understand how the classes of your test data, stored in iris.testLabels relate to your model that is stored in iris_pred:
CrossTable(x = iris.testLabels, y = iris_pred, prop.chisq=FALSE)

# note: From this table, you can derive the number of correct and incorrect predictions: one instance from the testing set was labeled Versicolor by the model, while it was actually a flower of species Virginica.







