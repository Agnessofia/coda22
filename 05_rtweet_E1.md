By Rodrigo Esteves de Lima Lopes *University of Campinas* [rll307\@unicamp.br](mailto:rll307@unicamp.br)

------------------------------------------------------------------------

# My first Twitter data scraping

# Introduction

Our main objective is to have a first contact with a data scraping package. In this case, `rtweet`. Twitter has been one of the oldest surviving social media, and it also has been an important source for data in the last few years. But please, take into account that the data we collect might be influenced by a number of factors:

1.  Twitter's algorithm is known to change the results depending of our location
2.  A different kind of account (professional, personal or premium) offers different results
3.  Our Internet band might influence the results

## What are we going to need

1.  A valid [Twitter](https://twitter.com/) account
2.  The Package [rtweet](https://github.com/ropensci/rtweet) for data scraping

### Responsible data use

Please, keep in mind that any data scraping should be done in accordance to Twitter's [terms and conditions](https://developer.twitter.com/en/developer-terms/more-on-restricted-use-cases).

# Scraping some data

Loading the package:

``` r
library(rtweet)
library(ggplot2)
```

## Twitter locations

First we are going to get some insights on what is trending in our location. So we start by checking which are the locations available:

``` r
all.trends <- trends_available()
```

If we have a close look, `my.trends <- trends_available()` delivers a table with numbers, cities and countries. I am from São Paulo - Brazil, so I will try to get the trends available there. If we look at the table, São Paulo's ID is `455827`. So we will get the trends by using this ID.

``` r
SP.trends <- get_trends(woeid = 455827)
```

Again we have a table. It is a snapshot of Twitter at the moment data were collected, it tends to change, sometimes, by the minute.

## Getting some tweets

In my data, the term **URSS** called my attention, so I will search for it. There are two ways to do so:

1.  `stream_tweets()`: searches tweets for a given period of time.
2.  `search_tweets()`: searches tweets until it gets specified number of tweets.

### stream_tweets

-   **Advantages**: it collects as much tweets as possible in a given period of time.
-   **Disadvantages**: it tends to get connection and parsing errors when we search for long periods of time. There is a function called recover_stream.R, written by [Johannes Gruber](https://github.com/JBGruber) (who we are quite deeply thankful) and available [here](https://gist.github.com/JBGruber), that might sort out the problem sometimes. However, if our file is too damaged, it may not work.

Let us make some search using `stream_tweets`:

``` r
stream_tweets('URSS', 
                       timeout = 60, #in seconds
                       file_name='t01', # it saves a the tweets in a file
                       parse=FALSE)
```

Now we will need the following commandto load this tweets:

``` r
my.tweets <- parse_stream("t01.json")
```

If we look at this file, there is a lot of possible variables to explore, over 90 columns with a lot of information regarding our tweets.

### search_tweets()

-   **Advantages**: always returns nice parsed files.
-   **Disadvantages**: if you do not have a researcher or premium account, number of instances might be limited.

Due to time, we will search for some tweets only:

``` r
my.Tweets2 <- search_tweets(
  "URSS", n = 1000, include_rts = TRUE)
```

Let us get the timeline form a politician:

``` r
boulos <-  get_timeline("GuilhermeBoulos",n=1000)
```

Let us get his followers

``` r
boulos.flw <- get_followers("GuilhermeBoulos", n = 75000)
```

Now let us get some information regarding some of those followers

``` r
boulos.flw2 <- boulos.flw[1:100,]
info <- lookup_users(boulos.flw2$user_id)
```

Getting some users who have tweeted about our search term:

``` r
users <- search_users("URSS", n = 1000)
```

# Timelines

Let us get the timelines for the some possible candidates in the next Brazilian's elections:

``` r
presidents <- get_timelines(c("jairbolsonaro",
                              "LulaOficial",
                              "cirogomes"),
                            n = 3200)
```


Now let us save our data outside R, if I want to analyse the texts in other software:

```r
presidets.save  <- data.frame(lapply(presidents, as.character), stringsAsFactors=FALSE)
write.csv(presidets.save, "presidents.csv")
```
