writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

# Packages ----------------------------------------------------------------

library(dplyr)
library(tidytext)
library(ggplot2)

# Vamos preparar as stopwords ----------------------------------------------------------------

my.stopwords <- data.frame(word = quanteda::stopwords("pt"))

# **Damares Alves** ----------------------------------------------------------------

damaresalves.w <- damaresalves %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # translates proportion to base 100

# Aqui buscamos melhorar nossas stopwords

my.stopwords <- data.frame(word = c(quanteda::stopwords("pt"),"rt","https","http", "t.co","s" ))

#vamos rodar novamente o código anterior:

damaresalves.w <- damaresalves %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # translates proportion to base 100


# Tereza Cristina ------------------------------------------------------------------

terezacristina.w <- terezacristina %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # translates proportion to base 100

# vamos melhorar nossa stop word lists

my.stopwords <- data.frame(word = c(quanteda::stopwords("pt"),"rt","https","http", "t.co","s","q", 'x' ))

terezacristina.w <- terezacristina %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # translates proportion to base 100

# **Damares Alves**

damaresalves.w  %>% 
  slice(1:25) %>% 
  ggplot(aes(x = reorder(word, n, function(n) -n), y = n)) + 
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  labs(
    x = "Words", y = "Frequency",
    title = "Frequência de palavras presentes nos tweets de Damares Alves",
    subtitle = "Levantamento de publicações a partir de janeiro de 2022",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )


# **Tereza Cristina**

terezacristina.w   %>% 
  slice(1:25) %>% 
  ggplot(aes(x = reorder(word, n, function(n) -n), y = n)) + 
  geom_bar(stat = "identity") + 
  theme(axis.text.x = element_text(angle = 60, hjust = 1)) +
  labs(
    x = "Words", y = "Frequency",
    title = "Frequência de palavras presentes nos tweets de Tereza Cristina",
    subtitle = "Levantamento de publicações a partir de janeiro de 2022",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )
