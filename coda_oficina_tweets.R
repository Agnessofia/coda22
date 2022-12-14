install.packages("rtweet")

library(rtweet)
auth_setup_default()
library(ggplot2)
library(dplyr)
options(scipen=999)

# Vamos pesquisar tendências em São Paulo?--------------------------------------------------
all.trends <- trends_available()
SaoPaulo.trends <- get_trends(woeid = 455827)

# Agora é hora de coletar tweets! -----------------------------------------------------

#Opção 1

# Pelo número de tweets
my.Tweets2 <- search_tweets(
  "06DeNovember", n = 1000, include_rts = TRUE)

# Vamos obter uma linha do tempo
damaresalves <- get_timeline("DamaresAlves", n = 1000)

# Vamos ver os seguidores?
damaresalves.flw <- get_followers("DamaresAlves",
                                  verbose = TRUE,n = 1000)

# Informações sobre os usuários 
damaresalves.flw2 <- damaresalves.flw[1:100,]
info <- lookup_users(damaresalves.flw2$from_id)

# aqui podemos escolher usuários que twittam sobre determinado tópico
users <- search_users("família", n = 1000)

---------------------------------------------------------------------------------------------------------------------------------------------------

# Vamos comparar a timeline das duas senadoras eleitas
damaresalves <- get_timeline("DamaresAlves", n = 3000)
terezacristina <- get_timeline("TerezaCrisMS", n = 3000)

# Vamos identificar cada senadora 

damaresalves$screen_name <- "DamaresAlves"
terezacristina$screen_name <- "TerezaCrisMS"

# Vamos juntar

senadoras <- rbind(damaresalves, terezacristina)

# Agora, vamos plotar as senadoras! 
# Para isso, vamos um utilizar um comando muito simples: 

damaresalves %>% ts_plot("month", trim = 7L)
terezacristina %>% ts_plot("month", trim = 7L)

# primeiro, vamos olhar para cada uma das senadoras
damaresalves %>% ts_plot("month", trim = 7L)
terezacristina %>% ts_plot("month", trim = 7L)

-------------------------------------------------------------------------------------------------------------------------------------------------

# Hora de melhorar os gráficos 

#Damares Alves

senadoras %>%
  dplyr::filter(created_at > "2022-01-01") %>%
  dplyr::filter(screen_name == "DamaresAlves") %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(color = "black",shape=21,fill="blue",size = 3) +
  ggplot2::geom_line(color = "blue")+
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
  dplyr::filter(screen_name == "TerezaCrisMS") %>%
  ts_plot("day", trim = 7L) +
  ggplot2::geom_point(color = "black",shape=21,fill="red",size = 3) +
  ggplot2::geom_line(color = "red")+
  ggplot2::theme_minimal() +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequência de tweets de Tereza Cristina",
    subtitle = "Twitter status (tweet) counts aggregated by day from January 2022",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

# Vamos juntar

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













