writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

# Packages ----------------------------------------------------------------

library(dplyr)
library(tidytext)
library(ggplot2)


# Preparing the data ----------------------------------------------------------------

LI <- subset(presidents, screen_name == "LulaOficial")
JB <- subset(presidents, screen_name == "jairbolsonaro")
CG <- subset(presidents, screen_name == "cirogomes")


my.stopwords <- data.frame(word = quanteda::stopwords("pt"))

# **Lula** ----------------------------------------------------------------

LI.w <- LI %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # translates proportion to base 100

# **Jair Bolsonaro**----------------------------------------------------------------

JB.w <- JB %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  anti_join(my.stopwords, by= "word") %>%
  mutate(freq = n / sum(n)) %>%
  mutate_at(vars(-matches("word|n")),~ .x * 100)

# **Ciro Gomes** ----------------------------------------------------------------


CG.w <- CG %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  anti_join(my.stopwords, by= "word") %>%
  mutate(freq = n / sum(n)) %>%
  mutate_at(vars(-matches("word|n")),~ .x * 100) 
