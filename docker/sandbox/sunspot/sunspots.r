# date: 9 Sept 2021

rm(list = ls()) # clear out the variables from memory to make a clean execution of the code.


# If you want to remove all previous plots and clear the console, run the following two lines.
graphics.off() # clear out all plots from previous work.

cat("\014") # clear the console



##### Sunspot data #####
# if necessary to install library
# install.packages("tidyverse")

library(tidyverse)
# library(ggplot2) 

# load the data
sunData <- read.table(file.choose(), header = TRUE, sep = ",")

# See what the data looks like
View(sunData)

# Load a data file directly from a path:
#sunData <- read.table("path/sunSpots.csv", header = TRUE, sep = ",")
names(sunData)

ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum))

# Add a smooth line to see general trends
ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum))

# Color by year
ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum))

# Color by month
ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = month)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear))

####
# Save the file
# what is the difference between the two graphs below?

png("~/Desktop/pngSave_sunSpots_yearVersusSunspots_1.png")

ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum))

dev.off()

ggsave("ggsave_sunSpots_yearVersusSunspots_1.png")

ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = month)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear))

dev.off()


# Save the other file
png("pngSave_sunSpots_yearVersusSunspots_2.png")

ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear))

dev.off()


# Another way to save the file.
ggsave("~/Deskop/ggsave_sunSpots_yearVersusSunspots_2_i.png")




ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = sunData$numObs, color = fracOfYear)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunData$numObs, color = fracOfYear))


ggplot(data = sunData) +  geom_point(mapping = aes(x = fracOfYear, y = numObs, color = fracOfYear)) + geom_smooth(mapping = aes(x = fracOfYear, y = sunspotNum, color = fracOfYear))

