writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

# Packages ----------------------------------------------------------------
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)
library(ggplot2)

#Creating the corpus
presidents.C <- corpus(presidents)

# Which are the variables?
head(docvars(presidents.C))

#Creating subcorpora
gabrielboric.c <- corpus_subset(presidents.C, screen_name == "gabrielboric")
sebastianpinera.c <- corpus_subset(presidents.C, screen_name == "sebastianpinera")

# Tokenisation
# Boric
gabrielboric.toc <- tokens(gabrielboric.c,
                   remove_punct = TRUE,
                   remove_symbols = TRUE,
                   remove_numbers = TRUE,
                   verbose = TRUE)
gabrielboric.toc <- tokens_remove(gabrielboric.toc,
                          stopwords("es"),
                          valuetype = "fixed",
                          verbose = TRUE
                          ) %>% tokens_tolower()

#Piñeda
sebastianpinera.toc <- tokens(sebastianpinera.c,
                   remove_punct = TRUE,
                   remove_symbols = TRUE,
                   remove_numbers = TRUE,
                   verbose = TRUE)

sebastianpinera.toc <- tokens_remove(sebastianpinera.toc,
                          stopwords("es"),
                          valuetype = "fixed",
                          verbose = TRUE
                          ) %>% tokens_tolower()

# Kwic
kwic(gabrielboric.toc,"chile") |> View()
kwic(sebastianpinera.toc,"chile") |> View()


#Bigrams
gabrielboric.col <- textstat_collocations(gabrielboric.toc, method = "lambda",
                                  size = 2,
                                  min_count = 2,
                                  smoothing = 0.5,
                                  tolower = TRUE,
                                  verbose = TRUE)

sebastianpinera.col <- textstat_collocations(sebastianpinera.toc, method = "lambda",
                                  size = 2,
                                  min_count = 2,
                                  smoothing = 0.5,
                                  tolower = TRUE,
                                  verbose = TRUE)
# Let us see it

View(gabrielboric.col)
View(sebastianpinera.col)


# Boric vs Piñeda
presidents.toc <- tokens(presidents.C,
                  remove_punct = TRUE,
                  remove_symbols = TRUE,
                  remove_numbers = TRUE,
                  verbose = TRUE) %>%
  tokens_remove(pattern = my.stopwords) %>%
  tokens_tolower() %>% 
  tokens_group(groups = screen_name)

dfm.pres <- dfm(presidents.toc, verbose = TRUE)

# Now Plotting

textstat_keyness(dfm.pres,
                 target = "gabrielboric",
                 measure = "lr") |> 
  textplot_keyness(n= 25)

















