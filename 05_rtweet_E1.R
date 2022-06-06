writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

# Packages ----------------------------------------------------------------
library(rtweet)
library(ggplot2)

# Doing research on topics--------------------------------------------------
all.trends <- trends_available()
SP.trends <- get_trends(woeid = 455827)

# getting some tweets -----------------------------------------------------
#Option 1

stream_tweets('URSS', 
              timeout = 60, #in seconds
              file_name='t01', # it saves a the tweets in a file
              parse=FALSE)

# For a given period of time
my.Tweets <- parse_stream("t01.json")

# By the number of tweets
my.Tweets2 <- search_tweets(
  "URSS", n = 1000, include_rts = TRUE)

# Getting a timeline
boulos <- get_timeline("GuilhermeBoulos", n = 1000)

# Getting the followers
boulos.flw <- get_followers("GuilhermeBoulos",
                            verbose = TRUE,n = 1000)

# Some information about the users
boulos.flw2 <- boulos.flw[1:100,]
info <- lookup_users(boulos.flw2$user_id)

# users who tweet about a topic
users <- search_users("URSS", n = 1000)

# Comparing two politicians
presidents <- get_timelines(c("jairbolsonaro",
                              "LulaOficial",
                              "cirogomes"),
                            n = 3200)

# Now we plot the presidents
# All in a single and simple command

presidents %>% ts_plot("month", trim = 7L)

# Now each presindet
# **Jair Bolsonaro**
  
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

# **Ciro Gomes**
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

# **Lula**
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

# All three
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

presidets.save  <- data.frame(lapply(presidents, as.character), stringsAsFactors=FALSE)
write.csv(presidets.save, "presidents.csv")

















