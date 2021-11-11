
rm(list = ls()) # clear out the variables from memory to make a clean execution of the code.

# If you want to remove all previous plots and clear the console, run the following two lines.
graphics.off() # clear out all plots from previous work.

cat("\014") # clear the console



#install.packages("janeaustenr")
#install.packages("stringr")
library(janeaustenr)
library(dplyr)
library(stringr)
library(tidyverse)




#install.packages("tidytext")
library(tidytext)
sentiments # words with sentiment


#install.packages("textdata")
library(textdata)
get_sentiments("afinn") # answer yes to these installations
get_sentiments("nrc")
get_sentiments("bing")


# Wrangling the book data

original_books <- austen_books() %>%
  group_by(book) %>%  
  mutate(linenumber = row_number(), chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]", ignore_case = TRUE)))) %>% ungroup()

# View(original_books) # words from all novels


tidy_books <- original_books %>%
  unnest_tokens(word, text) #make a list of words from the paragraphs

# View(tidy_books)

# Removing stop-words
data("stop_words")
# View(stop_words)

cleaned_books <- tidy_books %>% anti_join(stop_words) 
# anti_join() returns all rows from x where there are not matching values in y, keeping just columns from x.
# View(cleaned_books)


# Counting Common Words Across All Books
cleaned_books %>% 
  count(word, sort = TRUE) 


# Joy in Emma
nrcjoy <- get_sentiments("nrc") %>%
  filter(sentiment == "joy")

tidy_books %>%
  filter(book == "Emma") %>%
  semi_join(nrcjoy) %>%
  count(word, sort = TRUE)

# How Does Sentiment Change? (In each novel?)

library(tidyr)
bing <- get_sentiments("bing")

# move line by line of book, find difference in sentiments to “score” each line

janeaustensentiment <- tidy_books %>%
  inner_join(bing) %>%
  count(book, index = linenumber %/% 80, sentiment) %>% 
  spread(sentiment, n, fill = 0) %>% 
  mutate(sentiment = positive - negative)



# What Most Common Positive and Negative Words?

bing_word_counts <- tidy_books %>%
  inner_join(bing) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

# View(bing_word_counts)


# Plot the Good and Bad Words Across Each Book

ggplot(janeaustensentiment, aes(index, sentiment, fill = book)) + geom_bar(stat = "identity", show.legend = FALSE) + facet_wrap(~book, ncol = 2, scales = "free_x")


# Plot of Positive and Negative Sentiment Words

bing_word_counts %>%
  filter(n > 150) %>%
  mutate(n = ifelse(sentiment == "negative", -n, n)) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n, fill = sentiment)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  ylab("Contribution to sentiment")


# Get list of Positive and Negative Sentiments

bing_word_counts <- tidy_books %>%
  inner_join(get_sentiments("bing")) %>%
  count(word, sentiment, sort = TRUE) %>%
  ungroup()

# What are the sentiments of words?

  bing_word_counts

  
# Visually Shown, the sentiment words
  
  bing_word_counts %>%
    group_by(sentiment) %>%
    top_n(10) %>%
    ungroup() %>%
    mutate(word = reorder(word, n)) %>%
    ggplot(aes(word, n, fill = sentiment)) +
    geom_col(show.legend = FALSE) +
    facet_wrap(~sentiment, scales = "free_y") +
    labs(y = "Contribution to sentiment",
         x = NULL) +
    coord_flip()
  
  