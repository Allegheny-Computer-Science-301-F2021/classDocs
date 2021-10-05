# Date: 16 Sept 2021
# Code to track the infections of COVID-19 for comparison between countries


rm(list = ls()) # clear out the variables from memory to make a clean execution of the code.

# If you want to remove all previous plots and clear the console, run the following two lines.
graphics.off() # clear out all plots from previous work.

cat("\014") # clear the console


# Install the following libraries if they are not already setup on your machine.
#install.packages("tidyverse")
#install.packages("plotly")


# import the libraries to be able to use their code
library(tidyverse)
library(plotly)

## Get the most current coronavirus data ##

# Data reference: https://github.com/RamiKrispin/coronavirus/blob/master/data/coronavirus.rda
# Use GitHub's DOWNLOAD button to acquire the latest version of the data.



# If the file is in the working directory, the below code could be modified to automate the file loading.
#dataFile <- "coronavirus.rda"
#load(dataFile)


# If you have to search for the file using a file chooser panel, then use this code instead.
# file.exists(dataFile) #check to see if the file is availabe in the local directory
myFile <- file.choose()
load(myFile)


# View the data
View(coronavirus)

# What countries do I have data for analysis?
unique(coronavirus$country)

# What providences do I have data for analysis?
unique(coronavirus$province)


#### Plotting data ####

# Ensure all country data is same length by pulling data from same dataset.

# Isolate all the case and date information to create smaller tables that we will use.

# Filter out a subset of the data. This data matches the specified country and the term "confirmed" for type. Then plot these filter results. x-axis contains the chronology and y-axis contains data for confirmed cases.

#### #### #### #### #### #### 
# Kenya
#### #### #### #### #### #### 


KenyaDat <- coronavirus %>% filter(country == "Kenya", type == "confirmed") %>% select(date,cases,type)

names(KenyaDat)

names(KenyaDat) <- c("KenyaDate","KenyaCases", "type")

names(KenyaDat) # note the changed names of the columns

ggplot(KenyaDat, aes(KenyaDate, KenyaCases)) +  geom_line(color = "red" ) + ylab("Kenya Cumulative confirmed cases") + ggtitle("Country: Kenya")



#### #### #### #### #### #### 
# India
#### #### #### #### #### #### 


IndiaDat <- coronavirus %>% filter(country == "India", type == "confirmed") %>% select(date,cases,type)

names(IndiaDat)

names(IndiaDat) <- c("IndiaDate","IndiaCases", "type") 

names(IndiaDat) # note the changed names of the columns

ggplot(IndiaDat, aes(IndiaDate, IndiaCases)) +  geom_line(color = "red" ) + ylab("India Cumulative confirmed cases") + ggtitle("Country: India")



#### #### #### #### #### #### 
# Sweden
#### #### #### #### #### #### 


swedenDat <- coronavirus %>% filter(country == "Sweden", type == "confirmed") %>% select(date,cases,type)

names(swedenDat)

names(swedenDat) <- c("swedenDate","swedenCases", "type")

names(swedenDat) # note the changed names of the columns

ggplot(swedenDat, aes(swedenDate, swedenCases)) +  geom_line(color = "red" ) + ylab("Sweden Cumulative confirmed cases") + ggtitle("Country: Sweden")



#### #### #### #### #### #### 
# France
#### #### #### #### #### #### 

# Note: There are negative values (noise) in this plot!
# How can we fix our dataset to exclude this noise?
# Please see below for a working solution to handle noisy data.


franceDat <- coronavirus %>% filter(country == "France", type == "confirmed") %>% select(date,cases ,type)

names(franceDat)

names(franceDat) <- c("franceDate","franceCases", "type")

names(franceDat) # note the changed names of the columns

ggplot(franceDat, aes(franceDate, franceCases)) +  geom_line(color = "red" ) + ylab("France Cumulative confirmed cases") + ggtitle("Country: France")



#### #### #### #### #### #### 
# US
#### #### #### #### #### #### 



usDat <- coronavirus %>% filter(country == "US", type == "confirmed") %>% select(date,cases,type)

names(usDat)

names(usDat) <- c("usDate","usCases", "type")

names(usDat) # note the changed names of the columns

ggplot(usDat, aes(usDate, usCases)) +  geom_line(color = "red" ) + ylab("US Cumulative confirmed cases") + ggtitle("Country: USA")



#### #### #### #### #### #### 
# Italy
#### #### #### #### #### #### 




italyDat <- coronavirus %>% filter(country == "Italy", type == "confirmed") %>% select(date,cases,type)

names(italyDat)

names(italyDat) <- c("italyDate","italyCases", "type")

names(italyDat) # note the changed names of the columns

ggplot(italyDat, aes(italyDate, italyCases)) +  geom_line(color = "red" ) + ylab("Italy Cumulative confirmed cases") + ggtitle("Country: Italy")



#### #### #### #### #### #### 
# Bangladesh
#### #### #### #### #### #### 




BangladeshDat <- coronavirus %>% filter(country == "Bangladesh", type == "confirmed") %>% select(date,cases,type)

names(BangladeshDat)

names(BangladeshDat) <- c("BangladeshDate","BangladeshCases", "type")

names(BangladeshDat) # note the changed names of the columns

ggplot(BangladeshDat, aes(BangladeshDate, BangladeshCases)) +  geom_line(color = "red" ) + ylab("Bangladesh Cumulative confirmed cases") + ggtitle("Country: Bangladesh")



#### #### #### #### #### #### 
# New Zealand
#### #### #### #### #### #### 



nzDat <- coronavirus %>% filter(country == "New Zealand", type == "confirmed") %>% select(date,cases,type)

names(nzDat)

names(nzDat) <- c("nzDate","nzCases", "type")

names(nzDat) # note the changed names of the columns

ggplot(nzDat, aes(nzDate, nzCases)) +  geom_line(color = "red" ) + ylab("nz Cumulative confirmed cases") + ggtitle("Country: New Zealand")


#### Compare countries ####

# Establish the traces (sub datasets) for plotly.
# Each country needs own trace (a container of data) for plotting

trace_0 <- c(swedenDat$swedenCases)
trace_1 <- c(franceDat$franceCases)
trace_2 <- c(usDat$usCases)
trace_3 <- c(italyDat$italyCases)
trace_4 <- c(IndiaDat$IndiaCases)
trace_5 <- c(KenyaDat$KenyaCases)

# Establish the x-axis for chronology
x <- c(1:length(trace_0)) # need an x-axis so we will use the dates, note all these traces should be the same length and so we choose the first trace_0 for its length

# Add the traces from each country to the plot's canvas
myData <- data.frame(x, trace_0, trace_1, trace_2, trace_3, trace_4, trace_5)


# Combine individual traces to plot on same canvas

p <- plot_ly(myData, x = ~x, y = ~trace_0, name = "Sweden", type = 'scatter', mode = 'markers') %>% 
  add_trace( x = ~x, y = ~trace_1, name = "France", type = 'scatter', mode = 'markers') %>% 
  add_trace( x = ~x, y = ~trace_2, name = "US", type = 'scatter', mode = 'markers') %>%
  add_trace( x = ~x, y = ~trace_3, name = "Italy", type = 'scatter', mode = 'markers') %>%
  add_trace( x = ~x, y = ~trace_4, name = "India", type = 'scatter', mode = 'markers') %>%
  add_trace( x = ~x, y = ~trace_5, name = "Kenya", type = 'scatter', mode = 'markers')

# Show the plot
p




# This is same plot of data but here using a log transform to place all data on a similar scale

# Establish the traces (sub datasets) for plotly.
# Each country needs own trace (a container of data) for plotting

trace_0 <- c(swedenDat$swedenCases)
trace_1 <- c(franceDat$franceCases)
trace_2 <- c(usDat$usCases)
trace_3 <- c(italyDat$italyCases)
trace_4 <- c(IndiaDat$IndiaCases)
trace_5 <- c(KenyaDat$KenyaCases)

# Establish the x-axis
x <- c(1:length(trace_0)) # need an x-axis so we will use the dates, note all these traces should be the same length.

# Add the traces from each country to the plot's canvas
myData <- data.frame(x, trace_0, trace_1, trace_2, trace_3, trace_4, trace_5)



# Combine individual traces to plot on same canvas
p <- plot_ly(myData, x = ~x, y = ~log(trace_0), name = "Sweden", type = 'scatter', mode = 'markers') %>% 
  add_trace( x = ~x, y = ~log(trace_1), name = "France", type = 'scatter', mode = 'markers') %>% 
  add_trace( x = ~x, y = ~log(trace_2), name = "US", type = 'scatter', mode = 'markers') %>%
  add_trace( x = ~x, y = ~log(trace_3), name = "Italy", type = 'scatter', mode = 'markers') %>%
  add_trace( x = ~x, y = ~log(trace_4), name = "India", type = 'scatter', mode = 'markers') %>%
  add_trace( x = ~x, y = ~log(trace_5), name = "Kenya", type = 'scatter', mode = 'markers')

# show the plot using a log transform
p




## Wrangling data to remove noise ##
## since there are negative values in the cases, we want to overwrite this noise with zeros in a new dataset called franceDat_wrangled.

# Same code as above to create a dataset for France from the main dataset

franceDat <- coronavirus  %>% filter(country == "France", type == "confirmed") %>% select(date,cases, type)

#View(franceDat) # note the negative values (noise) for case!

names(franceDat) # note the column names

# We want to create a new dataset (called 'franceDat_wrangled') where the negative case values are replaced by zeros. This may introduce untruthful data into the entire set but is one way to deal with noise.

franceDat_wrangled <- mutate(franceDat, zeroNegatives = ifelse(cases >= 0, cases, 0 ))

#View(franceDat_wrangled) # note the new column

# Change the names of the columns to make them easier to use

names(franceDat_wrangled)

names(franceDat_wrangled) <- c("franceDate","franceCases","type", "zeroNegatives") 

names(franceDat_wrangled) # note the changed names of the columns


# note the new y-axis: we are now plotting y = zeroNegatives
ggplot(franceDat_wrangled, aes(franceDate, zeroNegatives)) +  geom_line(color = "red" ) + ylab("France Cumulative confirmed cases") + ggtitle("Country: France (Amended dataset)")


