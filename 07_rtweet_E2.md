By Rodrigo Esteves de Lima Lopes *University of Campinas* [rll307\@unicamp.br](mailto:rll307@unicamp.br)

------------------------------------------------------------------------

# Comparing Tweets
## Introduction

In this tutorial we will discuss how to make an initial exploration on Twitter textual data. Here we intend to perform an exploratory analysis of the text scraped from each candidates' timeline. 

We are going to use the following packages:

-   **dplyr** for data handling
-   **tidytext**  for text handling
-   **ggplot2** for plotting

```r
library(dplyr)
library(tidytext)
library(ggplot2)
```

# Preparing the data
Our first step is to isolate the text of each politician we are studying:

```r
LI <- subset(presidents, screen_name == "LulaOficial")
JB <- subset(presidents, screen_name == "jairbolsonaro")
CG <- subset(presidents, screen_name == "cirogomes")
```
Our next step is to create a stopwords list. Here we are going to use one which already exists, provided by `Quanteda`. We save it as a data frame in order to apply it to our tweets later. 

```r
my.stopwords <- data.frame(word = quanteda::stopwords("pt"))
```

Now we run the following command for each candidate, so we have three wordlists:

**Lula**

```r
LI.w <- LI %>%
  unnest_tokens(word, text) %>% # separates each word
  count(word, sort = TRUE) %>% # counts each word
  anti_join(my.stopwords, by= "word") %>% # delete stopwords
  mutate(freq = n / sum(n)) %>% # proportion (base 1)
  mutate_at(vars(-matches("word|n")),~ .x * 100)  # tanslates proportion to base 100
```
**Jair Bolsonaro**

```r
JB.w <- JB %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  anti_join(my.stopwords, by= "word") %>%
  mutate(freq = n / sum(n)) %>%
  mutate_at(vars(-matches("word|n")),~ .x * 100)
```

**Ciro Gomes**

```r
CG.w <- CG %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  anti_join(my.stopwords, by= "word") %>%
  mutate(freq = n / sum(n)) %>%
  mutate_at(vars(-matches("word|n")),~ .x * 100) 
```


