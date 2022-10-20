writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

# Packages ----------------------------------------------------------------

library(dplyr)
library(tidytext)
library(ggplot2)


# Preparing the stop words ----------------------------------------------------------------

my.stopwords <- data.frame(word = quanteda::stopwords("es"))

# **Boric** ----------------------------------------------------------------

gabrielboric.w <- gabrielboric %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # translates proportion to base 100

# improving the stop word lists

my.stopwords <- data.frame(word = c(quanteda::stopwords("es"),"rt","https","http", "t.co","s" ))

#running again


gabrielboric.w <- gabrielboric %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # translates proportion to base 100


# Piñeda ------------------------------------------------------------------

sebastianpinera.w <- sebastianpinera %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # translates proportion to base 100

# improving the stop word lists

my.stopwords <- data.frame(word = c(quanteda::stopwords("es"),"rt","https","http", "t.co","s","q", 'x' ))

sebastianpinera.w <- sebastianpinera %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # translates proportion to base 100


