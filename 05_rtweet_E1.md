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
library(dplyr)
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

# Now let us plot the frequency

The basic, one plot for all:

``` r
presidents %>% ts_plot("month", trim = 7L)
```

![Tweets in a single hand](images/t01.png)

`ts_plot()` is part of `rtweet`. It "borrows" some elements from `ggplot2` in order to plots frequency of tweets as time series. It is possible to make the visual representation a bit more sophisticated by providing multiple text-based filters to subset data. It is also possible to plot  multiple time series.

As we can see, this image does not give us much information about the tweets. So let us make the plot a bit more complex, now considering each candidate:

**Jair Bolsonaro**

``` r
presidents %>%
  dplyr::filter(created_at > "2022-01-01") %>%
  dplyr::filter(screen_name == "jairbolsonaro") %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(color = "black",shape=21,fill="blue",size = 3) +
  ggplot2::geom_line(color = "blue")+
  ggplot2::theme_minimal() +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Twitter statuses posted by Jair Bolsonaro",
    subtitle = "Twitter status (tweet) counts aggregated by day from January 2022",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )
```

![Tweets by Bolsonaro](images/T2.png)

**Ciro Gomes**

``` r
presidents %>%
  dplyr::filter(created_at > "2022-01-01") %>%
  dplyr::filter(screen_name == "cirogomes") %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(color = "black",shape=21,fill="darkgreen",size = 3) +
  ggplot2::geom_line(color = "darkgreen")+
  ggplot2::theme_minimal() +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Twitter statuses posted by Ciro Gomes",
    subtitle = "Twitter status (tweet) counts aggregated by day from January 2022",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )
```

![Tweets by Gomes](images/t3.png)

**Lula**

``` r
presidents %>%
  dplyr::filter(created_at > "2022-01-01") %>%
  dplyr::filter(screen_name == "LulaOficial") %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(color = "black",shape=21,fill="red",size = 3) +
  ggplot2::geom_line(color = "red")+
  ggplot2::theme_minimal() +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Twitter statuses posted by Lula",
    subtitle = "Twitter status (tweet) counts aggregated by day from January 2022",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )
```

![Tweets by Lula](images/t4.png)

In the commands above, a number of filters and new criteria changed the way data was represented. In a nutshell we:

1. chose a single candidate
1. set a data form the timeline to start
1. set a colour for each candidate
1. set the size


Now, let us plot all the presidents in a single command:

``` r
presidents %>%
  dplyr::filter(created_at > "2021-08-01") %>%
  dplyr::group_by(screen_name) %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(size = 3, aes(shape = factor(screen_name),color = factor(screen_name))) +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    legend.title = ggplot2::element_blank(),
    legend.position = "bottom",
    plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Twitter statuses posted by Brazilian Presidential Pre-Candidates",
    subtitle = "Twitter status (tweet) counts aggregated by date",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )
```

![All pre-candidates](images/all.png)

In a nutshell we:

1. chose all candidates
1. grouped the occurrences by screen name
1. set a data form the timeline to start
1. set a colour and shape for each candidate
1. set the size

Which conclusions can we get?
