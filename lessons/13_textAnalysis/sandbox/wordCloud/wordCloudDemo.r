# word cloud demo
# date: 11 Nov 2021
# updated code from ref: https://onepager.togaware.com/TextMiningO.pdf

rm(list = ls()) # clear out the variables from memory to make a clean execution of the code.

# If you want to remove all previous plots and clear the console, run the following two lines.
graphics.off() # clear out all plots from previous work.

cat("\014") # clear the console




# Required packages
#install.packages("tm")
library(tm)

#install.packages("wordcloud")
library(wordcloud)

# install directory picker library
#install.packages("easycsv")

# Locate and load the Corpus.

#set path to data such as, data/sherlockHolmes/
dataDirectory <- easycsv::choose_dir() # pick the directory where the data is stored.


docs <- Corpus(DirSource(dataDirectory))
docs
summary(docs)
# inspect(docs[1]) # show the words


# Transforms
toSpace <- content_transformer(function(x, pattern) gsub(pattern, " ", x)) #replace-all function
docs <- tm_map(docs, toSpace, "/|@|\\|")
docs <- tm_map(docs, content_transformer(tolower))
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeWords, stopwords("english"))
docs <- tm_map(docs, removeWords, c("own", "stop", "words"))
docs <- tm_map(docs, stripWhitespace)
toString <- content_transformer(function(x, from, to) gsub(from, to, x)) # 
docs <- tm_map(docs, toString, "specific transform", "ST") # if you have specifics to remove, add them here
docs <- tm_map(docs, toString, "other specific transform", "OST")
docs <- tm_map(docs, stemDocument)

# Document term matrix.
dtm <- DocumentTermMatrix(docs)
#inspect(dtm[1:5, 1000:1005])
dtm


# determine a subset of words to place into a word cloud

lowerbound <- 40 # freq of the words to place into the plot. Here upper upper 80 per cent

#findFreqTerms(dtm, lowfreq=100)
findFreqTerms(dtm, lowfreq=lowerbound) # determine words of similar frequencies, lower bound freq is 100

findAssocs(dtm, "data", corlimit=0.6) #determine words having same types of values (here, value = 0.6)
freq <- sort(colSums(as.matrix(dtm)), decreasing=TRUE)
wf <- data.frame(word=names(freq), freq=freq)

library(ggplot2)

p <- ggplot(subset(wf, freq>500), aes(word, freq))
p <- p + geom_bar(stat="identity")
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))

# Generate a word cloud
library(wordcloud)
#wordcloud(names(freq), freq, min.freq=100, colors=brewer.pal(6, "Dark2"))
wordcloud(names(freq), freq, min.freq=lowerbound, colors=brewer.pal(6, "Dark2"))

