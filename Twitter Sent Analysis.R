### Sentiment Analysis on Twitter Data

install.packages("twitteR")
install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("plyr")
install.packages("ggplot2")
install.packages("httr")
install.packages("devtools")
install.packages("RCurl")
install.packages("qdap")
install.packages("tm")
install.packages("NLP")

library(twitteR)
library(devtools)
library(wordcloud)
library(RColorBrewer)
library(plyr)
library(ggplot2)
library(httr)
library(qdap)
library(tm)
library(NLP)
library(data.table)
library(stringr)

# Find and setup OAuth settings for twitter:

oauth_endpoints("twitter")


## [1] “Using direct authentication”

# Collect 1.000 tweets containing the term “datascience” from twitter (language = English)
datascience_tweets = searchTwitter("datascience", n=10000, lang="en")

## Fetch the text of these tweets:
datascience_txt = sapply(datascience_tweets, function(x) x$getText())

## Prepare the text for sentiment analysis

## Remove retweet entities from the stored tweets (text)
datascience_txt = gsub("(RT|via)((?:\\b\\W*@\\w+)+)", "", datascience_txt)

# Remove all “@people”
datascience_txt = gsub("@\\w+", "", datascience_txt)

# Remove all the punctuation
datascience_txt = gsub("[[:punct:]]", "", datascience_txt)

# Remove numbers, we need only text for analytics
datascience_txt = gsub("[[:digit:]]", "", datascience_txt)

# Remove html links, which are not required for sentiment analysis
datascience_txt = gsub("http\\w+", "", datascience_txt)

# Remove unnecessary spaces (white spaces, tabs etc)
datascience_txt = gsub("[ \t]{2,}", "", datascience_txt)
datascience_txt = gsub("^\\s+|\\s+$", "", datascience_txt)

# Remove NAs, if any exists, from datascience_txt (the collected and refined text in analysis)
datascience_txt = datascience_txt[!is.na(datascience_txt)]

# Remove names (column headings) from the text, as we do not want them in the sentiment analysis
names(datascience_txt) = NULL

## Save Tweets as CSV

twListToDF <- function(twList)

datascience.df = twListToDF(datascience_txt)
write.csv(datascience.df, file = '/Documents/WIP/DataSci/Working R/Twitter Sentiment Analysis DataSci/DataSci.csv')

traceback()

## Sentiment analysis



tryTolower = function(x)
{
  # create missing value
  # this is where the returned value will be
  y = NA
  # tryCatch error
  try_error = tryCatch(tolower(x), error = function(e) e)
  # if not an error
  if (!inherits(try_error, "error"))
    y = tolower(x)
  return(y)
}

tolower(datascience_txt)

sapply(datascience_txt, function(x) tryTolower(x))

polarity.datascience_txt <- polarity(datascience_txt)


