# Load the package

install.packages("twitteR")
install.packages("wordcloud")
install.packages("tm")

library(twitteR)
library(wordcloud)
library(tm)

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
datacience_tweets <- searchTwitter("#datascience", n=10000)

length(datacience_tweets)
#[1] 10000

# Save as text
datacience_tweets_text <- sapply(datacience_tweets, function(x) x$getText())

# Create corpus
datacience_tweets_text_corpus <- Corpus(VectorSource(datacience_tweets_text))

# Clean up
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, content_transformer(tolower), lazy=TRUE) 
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, removePunctuation)
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, function(x)removeWords(x,stopwords()))
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, PlainTextDocument)
wordcloud(datacience_tweets_text_corpus)

#if you get the below error
#In mclapply(content(x), FUN, ...) :
#  all scheduled cores encountered errors in user code
#add mc.cores=1 into each function

# run this step if you get the error:
# (please break it!)' in 'utf8towcs'
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus,
                              content_transformer(function(x) iconv(x, to='utf8towcs', sub='byte)),
                              mc.cores=1)
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, content_transformer(tolower), mc.cores=1)
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, removePunctuation, mc.cores=1)
datacience_tweets_text_corpus <- tm_map(datacience_tweets_text_corpus, function(x) removeWords(x,stopwords()), mc.cores=1)
wordcloud(datacience_tweets_text_corpus)

