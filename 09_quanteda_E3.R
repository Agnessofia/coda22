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
lula.c <- corpus_subset(presidents.C, screen_name == "LulaOficial")
ciro.c <- corpus_subset(presidents.C, screen_name == "cirogomes")
JB.c <- corpus_subset(presidents.C, screen_name == "jairbolsonaro")

# Tokenisation
#Lula
lula.toc <- tokens(lula.c,
                   remove_punct = TRUE,
                   remove_symbols = TRUE,
                   remove_numbers = TRUE,
                   verbose = TRUE)
lula.toc <- tokens_remove(lula.toc,
                          stopwords("pt"),
                          valuetype = "fixed",
                          verbose = TRUE
                          ) %>% tokens_tolower()

#Ciro
ciro.toc <- tokens(ciro.c,
                   remove_punct = TRUE,
                   remove_symbols = TRUE,
                   remove_numbers = TRUE,
                   verbose = TRUE)
ciro.toc <- tokens_remove(ciro.toc,
                          stopwords("pt"),
                          valuetype = "fixed",
                          verbose = TRUE
                          ) %>% tokens_tolower()
# JB
JB.toc <- tokens(JB.c,
                   remove_punct = TRUE,
                   remove_symbols = TRUE,
                   remove_numbers = TRUE,
                   verbose = TRUE)
JB.toc <- tokens_remove(JB.toc,
                          stopwords("pt"),
                          valuetype = "fixed",
                          verbose = TRUE
                        ) %>% tokens_tolower()

# Kwic
kwic(JB.toc,"Brasil") |> View()
kwic(lula.toc,"Brasil") |> View()
kwic(ciro.toc,"Brasil") |> View()

#Bigrams
lula.col <- textstat_collocations(lula.toc, method = "lambda",
                                  size = 2,
                                  min_count = 2,
                                  smoothing = 0.5,
                                  tolower = TRUE,
                                  verbose = TRUE)

ciro.col <- textstat_collocations(ciro.toc, method = "lambda",
                                  size = 2,
                                  min_count = 2,
                                  smoothing = 0.5,
                                  tolower = TRUE,
                                  verbose = TRUE)

JB.col <- textstat_collocations(JB.toc, method = "lambda",
                                  size = 2,
                                  min_count = 2,
                                  smoothing = 0.5,
                                  tolower = TRUE,
                                  verbose = TRUE)

# Comparing the candidates
a.lula_Ciro <- corpus_subset(presidents.C, screen_name != "jairbolsonaro")
b.lula_JB <- corpus_subset(presidents.C, screen_name != "cirogomes")
c.ciro_JB <- corpus_subset(presidents.C, screen_name != "LulaOficial")

# Lula vs ciro
a.tk <- tokens(a.lula_Ciro,
                  remove_punct = TRUE,
                  remove_symbols = TRUE,
                  remove_numbers = TRUE,
                  verbose = TRUE) %>%
  tokens_remove(pattern = stopwords("pt")) %>%
  tokens_group(groups = screen_name)

dfm.a <- dfm(a.tk, verbose = TRUE)

textstat_keyness(dfm.a,
                 target = "LulaOficial",
                 measure = "lr") |> 
  textplot_keyness(n= 25)


# Lula vs JB

b.tk <- tokens(b.lula_JB,
               remove_punct = TRUE,
               remove_symbols = TRUE,
               remove_numbers = TRUE,
               verbose = TRUE) %>%
  tokens_remove(pattern = stopwords("pt")) %>%
  tokens_group(groups = screen_name)

dfm.b <- dfm(b.tk, verbose = TRUE)

textstat_keyness(dfm.b,
                 target = "LulaOficial",
                 measure = "lr") |> 
  textplot_keyness(n= 25)

# Ciro vs JB

c.tk <- tokens(c.ciro_JB,
               remove_punct = TRUE,
               remove_symbols = TRUE,
               remove_numbers = TRUE,
               verbose = TRUE) %>%
  tokens_remove(pattern = stopwords("pt")) %>%
  tokens_group(groups = screen_name)

dfm.c <- dfm(c.tk, verbose = TRUE)

textstat_keyness(dfm.c,
                 target = "cirogomes",
                 measure = "lr") |> 
  textplot_keyness(n= 25)


















