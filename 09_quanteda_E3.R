writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

# Packages ----------------------------------------------------------------
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)
library(ggplot2)


#Vamos criar um corpus
senadoras.C <- corpus(senadoras)

# Which are the variables?
head(docvars(senadoras.C))

#Vamos criar subcorpora
damaresalves.c <- corpus_subset(senadoras.C, screen_name == "DamaresAlves")
terezacristina.c <- corpus_subset(senadoras.C, screen_name == "TerezaCrisMS")

# Tokenização
# Damares Alves
damaresalves.toc <- tokens(damaresalves.c,
                           remove_punct = TRUE,
                           remove_symbols = TRUE,
                           remove_numbers = TRUE,
                           verbose = TRUE)
damaresalves.toc <- tokens_remove(damaresalves.toc,
                                  stopwords("pt"),
                                  valuetype = "fixed",
                                  verbose = TRUE
) %>% tokens_tolower()

#Tereza Cristina
terezacristina.toc <- tokens(terezacristina.c,
                              remove_punct = TRUE,
                              remove_symbols = TRUE,
                              remove_numbers = TRUE,
                              verbose = TRUE)

terezacristina.toc <- tokens_remove(terezacristina.toc,
                                     stopwords("pt"),
                                     valuetype = "fixed",
                                     verbose = TRUE
) %>% tokens_tolower()

# Kwic
kwic(damaresalves.toc,"brasil") |> View()
kwic(terezacristina.toc,"brasil") |> View()


#Bigrams
damaresalves.col <- textstat_collocations(damaresalves.toc, method = "lambda",
                                          size = 2,
                                          min_count = 2,
                                          smoothing = 0.5,
                                          tolower = TRUE,
                                          verbose = TRUE)

terezacristina.col <- textstat_collocations(terezacristina.toc, method = "lambda",
                                             size = 2,
                                             min_count = 2,
                                             smoothing = 0.5,
                                             tolower = TRUE,
                                             verbose = TRUE)
# Let us see it

View(damaresalves.col)
View(terezacristina.col)


# Damares Alves vs Tereza Cristina
senadoras.toc <- tokens(senadoras.C,
                         remove_punct = TRUE,
                         remove_symbols = TRUE,
                         remove_numbers = TRUE,
                         verbose = TRUE) %>%
  tokens_remove(pattern = my.stopwords) %>%
  tokens_tolower() %>% 
  tokens_group(groups = screen_name)

dfm.sen <- dfm(senadoras.toc, verbose = TRUE)


