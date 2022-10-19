writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

# Packages ----------------------------------------------------------------
library(rtweet)
auth_setup_default()
library(ggplot2)
library(dplyr)
options(scipen=999)
# Doing research on topics--------------------------------------------------
all.trends <- trends_available()
Santigo.trends <- get_trends(woeid = 349859)

# getting some tweets -----------------------------------------------------
#Option 1

stream_tweets('18DeOctubre',
              timeout = 60, #in seconds
              file_name='t01', # it saves a the tweets in a file
              parse=FALSE)

# For a given period of time
my.Tweets <- parse_stream("t01")

# By the number of tweets
my.Tweets2 <- search_tweets(
  "18DeOctubre", n = 1000, include_rts = TRUE)

# Getting a timeline
gabrielboric <- get_timeline("gabrielboric", n = 1000)

# Getting the followers
gabrielboric.flw <- get_followers("gabrielboric",
                            verbose = TRUE,n = 1000)

# Some information about the users
gabrielboric.flw2 <- gabrielboric.flw[1:100,]
info <- lookup_users(gabrielboric.flw2$from_id)

# users who tweet about a topic
users <- search_users("18DeOctubre", n = 1000)

# Comparing two politicians
gabrielboric <- get_timeline("gabrielboric", n = 3000)
sebastianpinera <- get_timeline("sebastianpinera", n = 3000)

# Identifying the origin of each president:

gabrielboric$screen_name <- "gabrielboric"
sebastianpinera$screen_name <- "sebastianpinera"

# Merging

presidents <- rbind(gabrielboric,sebastianpinera)

# Now we plot the presidents
# All in a single and simple command

gabrielboric %>% ts_plot("month", trim = 7L)
sebastianpinera %>% ts_plot("month", trim = 7L)

# Now each presindet
# **Gabriel Boric**
  
presidents %>%
  dplyr::filter(created_at > "2022-01-01") %>%
  dplyr::filter(screen_name == "gabrielboric") %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(color = "black",shape=21,fill="red",size = 3) +
  ggplot2::geom_line(color = "red")+
  ggplot2::theme_minimal() +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Twitter statuses posted by Gabriel Boric",
    subtitle = "Twitter status (tweet) counts aggregated by day from January 2022",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

# **Sebastian Piñera**
presidents %>%
  dplyr::filter(created_at > "2022-01-01") %>%
  dplyr::filter(screen_name == "sebastianpinera") %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(color = "black",shape=21,fill="blue",size = 3) +
  ggplot2::geom_line(color = "blue")+
  ggplot2::theme_minimal() +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Twitter statuses posted by Sebastian Piñera",
    subtitle = "Twitter status (tweet) counts aggregated by day from January 2022",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )


# The two
presidents %>%
  dplyr::filter(created_at > "2022-01-01") %>%
  dplyr::group_by(screen_name) %>%
  ts_plot("day", trim = 15L) +
  ggplot2::geom_point(size = 3, aes(shape = factor(screen_name),color = factor(screen_name))) +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    legend.title = ggplot2::element_blank(),
    legend.position = "bottom",
    plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Twitter statuses posted by Chilean Presidentss",
    subtitle = "Twitter status (tweet) counts aggregated by date",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

presidets.save  <- data.frame(lapply(presidents, as.character), stringsAsFactors=FALSE)
write.csv(presidets.save, "presidents.csv")

















