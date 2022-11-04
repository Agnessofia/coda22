Este script foi elaborado pelo prof Dr. Rodrigo Esteves de Lima-Lopes, com a ajuda de Agnes Sofia Guimarães Cruz, doutoranda no programa de Linguística Aplicada da Universidade Estadual de Campinas(UNICAMP). 

writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

# Packages ----------------------------------------------------------------
library(rtweet)
auth_setup_default()
library(ggplot2)
library(dplyr)
options(scipen=999)
# Doing research on topics--------------------------------------------------
all.trends <- trends_available()
SaoPaulo.trends <- get_trends(woeid = 455827)

# getting some tweets -----------------------------------------------------
#Option 1

stream_tweets('06DeNovember',
              timeout = 60, #in seconds
              file_name='t01', # it saves a the tweets in a file
              parse=FALSE)

# For a given period of time
my.Tweets <- parse_stream("t01")

# By the number of tweets
my.Tweets2 <- search_tweets(
  "06DeNovember", n = 1000, include_rts = TRUE)

# Getting a timeline
damaresalves <- get_timeline("damaresalves", n = 1000)

# Getting the followers
damaresalves.flw <- get_followers("damaresalves",
                            verbose = TRUE,n = 1000)

# Some information about the users
damaresalves.flw2 <- damaresalves.flw[1:100,]
info <- lookup_users(damaresalves.flw2$from_id)

# users who tweet about a topic
users <- search_users("06DeNovember", n = 1000)

# Comparing two politicians
damaresalves <- get_timeline("damaresalves", n = 3000)
terezacristina <- get_timeline("terezacristina", n = 3000)

# Identifying the origin of each president:

damaresalves$screen_name <- "damaresalves"
terezacristina$screen_name <- "terezacristina"

# Merging

senadoras <- rbind(damaresalves, tereza cristina)

# Agora, vamos plotar as senadoras! 
# Para isso, vamos um utilizar um comando muito simples: 

damaresalves %>% ts_plot("month", trim = 7L)
terezacristina %>% ts_plot("month", trim = 7L)

# Agora, cada senadora
# **Damares Alves**
  
senadoras %>%
  dplyr::filter(created_at > "2022-01-01") %>%
  dplyr::filter(screen_name == "damaresalves") %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(color = "black",shape=21,fill="red",size = 3) +
  ggplot2::geom_line(color = "red")+
  ggplot2::theme_minimal() +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequência de tweets de Damares Alves",
    subtitle = "Twitter status (tweet) counts aggregated by day from January 2022",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

# **Tereza Cristina**
senadoras %>%
  dplyr::filter(created_at > "2022-01-01") %>%
  dplyr::filter(screen_name == "terezacristina") %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(color = "black",shape=21,fill="blue",size = 3) +
  ggplot2::geom_line(color = "blue")+
  ggplot2::theme_minimal() +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequência de tweets de Tereza Cristina",
    subtitle = "Informações agregadas por data",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )


# The two
senadoras %>%
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
    title = "Frequência de tweets de políticas brasileiras e de direita",
    subtitle = "Informações agregadas por data",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

senadoras.save  <- data.frame(lapply(senadoras, as.character), stringsAsFactors=FALSE)
write.csv(senadoras.save, "senadoras.csv")

















