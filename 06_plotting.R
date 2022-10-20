writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

# each one 
gabrielboric %>% ts_plot("month", trim = 7L)
sebastianpinera %>% ts_plot("month", trim = 7L)

# Improved plotting

#Piñeda

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

# Both

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
    title = "Frequency of Twitter statuses posted by Chilean Presidents",
    subtitle = "Twitter status (tweet) counts aggregated by date",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )
