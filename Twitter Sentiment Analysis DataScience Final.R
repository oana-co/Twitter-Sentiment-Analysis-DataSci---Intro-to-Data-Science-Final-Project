# Load the package

install.packages("twitteR")
install.packages("wordcloud")
install.packages("tm")
install.packages("SnowballC")

library(twitteR)
library(wordcloud)
library(tm)
library(SnowballC)

# to get your consumerKey and consumerSecret see the twitteR documentation for instructions
consumer_key <- 'q0wvm80ceeCGml0UmK7Dl7hvP'
consumer_secret <- 'LE3RvKLuzUncx4T6AjpHNMlhNHABNEtVg9lriiJWLHyD18YS6B'
access_token <- '54455879-yPWU2L26jrBGSuh5duFe10aE3KkTlCI17lftzBOUw'
access_secret <- 'TCG72FRR5x3NUEtiFdv5Nq5fbUasenbiUJSx61Txdk5ub'
setup_twitter_oauth(consumer_key,
                    consumer_secret,
                    access_token,
                    access_secret)

# Get the tweets
datacience_tweets <- searchTwitter("#datascience", n=1000)

length(datacience_tweets)
#[1] 10000

# Save as text
datacience_tweets_text <- sapply(datacience_tweets, function(x) x$getText())

# Create corpus
datacience_tweets_text_corpus <- Corpus(VectorSource(datacience_tweets_text))

wordcloud(datacience_tweets_text_corpus)

# Clean up
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus,
                                        content_transformer(function(x) iconv(x, to='UTF-8-MAC', sub='byte'))
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, 
                                        content_transformer(tolower), lazy=TRUE) 
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, 
                                        removePunctuation, lazy=TRUE, mc.cores=1)
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, 
                                        function(x)removeWords(x,stopwords()), lazy=TRUE, mc.cores=1)

# Create word clouds

wordcloud(datacience_tweets_text_corpus)

wordcloud(datacience_tweets_text_corpus, scale=c(3,0.5), 
          max.words=100, random.order=FALSE, rot.per=0.5, use.r.layout=FALSE, colors=brewer.pal(7, "Dark2"))

pal2 <- brewer.pal(8,"Dark2")
wordcloud(datacience_tweets_text_corpus,min.freq=2,max.words=100, random.order=F, colors=pal2)

# Create data frame from Tweets

datascience_df <- do.call("rbind", lapply(datacience_tweets, as.data.frame))
write.csv(datascience_df, file='TweetsDataSci.csv')

head(datascience_df, 3)

# Sentiment function

library(plyr)
library(stringr)

score.sentiment = function(sentences, pos.words, neg.words, .progress='none')
{
  require(plyr)
  require(stringr)
  # we got a vector of sentences. plyr will handle a list
  # or a vector as an "l" for us
  # we want a simple array ("a") of scores back, so we use
  # "l" + "a" + "ply" = "laply":
  scores = laply(sentences, function(sentence, pos.words, neg.words) {
    # clean up sentences with R's regex-driven global substitute, gsub():
    sentence = gsub('[[:punct:]]', '', sentence)
    sentence = gsub('[[:cntrl:]]', '', sentence)
    sentence = gsub('\\d+', '', sentence)
    # and convert to lower case:
    sentence = tolower(sentence)
    # split into words. str_split is in the stringr package
    word.list = str_split(sentence, '\\s+')
    # sometimes a list() is one level of hierarchy too much
    words = unlist(word.list)
    # compare our words to the dictionaries of positive & negative terms
    pos.matches = match(words, pos.words)
    neg.matches = match(words, neg.words)
    # match() returns the position of the matched term or NA
    # we just want a TRUE/FALSE:
    pos.matches = !is.na(pos.matches)
    neg.matches = !is.na(neg.matches)
    # and conveniently enough, TRUE/FALSE will be treated as 1/0 by sum():
    score = sum(pos.matches) - sum(neg.matches)
    return(score)
    }, pos.words, neg.words, .progress=.progress )
  scores.df = data.frame(score=scores, text=sentences)
  return(scores.df)
}

# Scoring Tweets and adding column

# Load sentiment word lists

hu.liu.pos = scan('/Users/oanacalugar/Documents/WIP/DataSci/Working\ R/Twitter\ Sentiment\ Analysis\ DataSci/positive-words.txt', 
                  what='character', comment.char=';') 

hu.liu.neg = scan('/Users/oanacalugar/Documents/WIP/DataSci/Working\ R/Twitter\ Sentiment\ Analysis\ DataSci/negative-words.txt', 
                  what='character', comment.char=';')

# Add words to list

pos.words = c(hu.liu.pos, 'upgrade')
neg.words = c(hu.liu.neg, 'wtf', 'wait', 'epicfail', 'hype')

# Import the CSV file

DatasetDataSci <- read.csv("/Users/oanacalugar/Documents/WIP/DataSci/Working\ R/Twitter\ Sentiment\ Analysis\ DataSci/TweetsDataSci.csv")

DatasetDataSci$text <- as.factor(DatasetDataSci$text)

# Score all Tweets

DataSci.scores = score.sentiment(DatasetDataSci$text, pos.words, neg.words, .progress='text')
path <- "/Users/oanacalugar/Documents/WIP/DataSci/Working\ R/Twitter\ Sentiment\ Analysis\ DataSci/"
write.csv(DataSci.scores, file=paste(path, "DataSciScores.csv", sep=""), row.names=T)

# Visualising the Tweets

install.packages("ggplot2")
library(ggplot2)
library(RColorBrewer)

hist(DataSci.scores$score, xlab="Score of Tweets", col=brewer.pal(9, "Set3"))
qplot(DataSci.scores$score, xlab="Score of Tweets")




