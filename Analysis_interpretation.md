# Twitter-Sentiment-Analysis-DataSci---Intro-to-Data-Science-Final-Project

**Interpretation of results**

The histogram shows the frequency of tweets with respect of scores allotted to each tweets. 
The x-axis shows the score of each tweet as a negative and positive integer or zero. 
A positive score represents positive or good sentiments associated with that particular tweet 
whereas a negative score represents negative or bad sentiments associated with that tweet. 
A score of zero indicates a neutral sentiment. The more positive the score, the more positive 
the sentiments of the person tweeting and vice-versa.
The above histogram is skewed towards positive score which shows that the sentiments of people 
tweeting about 'Data Science' are positive.

Out of 1000 tweets that were fetched from the twitter, A majority of them (662) are neutral, 
whereas around 120 were having negative sentiments. 218 tweets were having positive sentiments 
and the overall score is positive as can be seen from the plot. 

**Limitations of the analysis**

There are certain limitations while doing Twitter Analysis using R: 

1. While getting Status of user timeline the method can only return a fixed maximum number of 
tweets which is limited by the Twitter API. 

2. While requesting tweets for a particular keyword, it sometime happens that the number of retrieved 
tweets are less than the number of requested tweets.

3. While requesting tweets for a particular keyword, the older tweets cannot be retrieved. 

4. It would be too naive to oversimplify language thinking that its underlying sentiment can always be 
accurately examined by a machine or an algorithm"

There are four main factors that currently stop us from relying blindly on tools for sentiment analysis:

A. Context: a positive or negative sentiment word can have the opposite connotation depending on context 
(e.g. “my internet provider does a great job when it comes to stealing money from me”. )
B. Sentiment Ambiguity: a sentence with a positive or negative word doesn’t necessarily express any sentiment. 
(e.g. “can you recommend a good tool I could use?” doesn’t express any sentiment, although it uses the 
positive sentiment word “good“). Likewise, sentences without sentiment words can express sentiment too. 
(e.g. “This browser uses a lot of memory” doesn’t contain any sentiment words, although it’s clearly 
negative at a document level.)
C. Sarcasm: a positive or negative sentiment word can switch sentiment if there is sarcasm in the sentence 
(e.g. “Sure, I’m happy for my browser to crash right in the middle of my coursework”).
D. Language: a word can change sentiment and meaning depending on the language used. This is often seen 
in slang, dialects, and language variations. An example is the word “sick“, which can change meaning based 
on context, tone and language, although clear to the target audience.

**Future analysis**

While sometimes used interchangeably, emotion and sentiment aren’t the same, especially in sentiment analysis. 
Sentiment is influenced by emotion, a subjective feeling or thought. The strength of a sentiment is usually 
linked to the intensity of emotions felt by the opinion holder.

It’s helpful to make a distinction between rational and emotional evaluations:

Rational evaluation: evaluations from rational reasoning and tangible beliefs (e.g. “The reports from this tool are very useful”).
Emotional evaluation: evaluations from non-tangible and emotional impulses (e.g. “These reports are the best ever!”).
After making this distinction, we could build a sentiment scoring system, taking into consideration the following sentiment ratings:

* (+2) emotional positive
* (+1) rational positive
* (0) neutral
* (-1) rational negative
* (-2) emotional negative

The next step is to develop a new model using n-grams; n-gram is a contiguous sequence of n items from a given 
sequence of text or speech. The items can be phonemes, syllables, letters, words or base pairs according to the application. The n-grams typically are collected from a text or speech corpus. 

N-gram models can be imagined as placing a small window over a sentence or a text, in which only n words are visible at the same time.

An n-gram of size 1 is referred to as a "unigram"; size 2 is a "bigram" (or, less commonly, a "digram"); size 3 is a "trigram". Larger sizes are sometimes referred to by the value of n, e.g., "four-gram", "five-gram", and so on.


