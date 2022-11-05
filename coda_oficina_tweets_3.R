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

#Agora, vamos pensar em redes

# Damares

#creating a general DFM
damaresalves.dfm <- dfm(damaresalves.toc)

#Selecting the most frequent words
damaresalves.top <- names(topfeatures(damaresalves.dfm, 30))

#Selecting the most common words to print
damaresalves.fcm <-fcm(damaresalves.dfm)
damaresalves.top.fcm <- fcm_select(damaresalves.fcm, pattern = damaresalves.top)

textplot_network(damaresalves.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')

#Selecting the hashtag
damaresalves.tags <- dfm_select(damaresalves.dfm, pattern = ("#*"))
damaresalves.tags.top <- names(topfeatures(damaresalves.tags, 100))

# Now let us construct a FCM
damaresalves.tags.fcm <- fcm(damaresalves.tags)

# Let us make a FCM only with the top hashtags

damaresalves.top.hash <- fcm_select(damaresalves.tags.fcm, pattern = damaresalves.tags.top)

textplot_network(damaresalves.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')

#Selecting the handles
damaresalves.handle <- dfm_select(damaresalves.dfm, pattern = ("@*"))
damaresalves.handle.top <- names(topfeatures(damaresalves.handle, 100))

# Now let us construct a FCM
damaresalves.handle.fcm <- fcm(damaresalves.handle)

# Let us make a FCM only with the top handles

damaresalves.top.handles <- fcm_select(damaresalves.handle.fcm, pattern = damaresalves.handle.top)

textplot_network(damaresalves.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')


# damaresalves

#creating a general DFM
damaresalves.dfm <- dfm(damaresalves.toc)

#Selecting the most frequent words
damaresalves.top <- names(topfeatures(damaresalves.dfm, 30))

#Selecting the most common words to print
damaresalves.fcm <-fcm(damaresalves.dfm)
damaresalves.top.fcm <- fcm_select(damaresalves.fcm, pattern = damaresalves.top)

textplot_network(damaresalves.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')

#Selecting the hashtag
damaresalves.tags <- dfm_select(damaresalves.dfm, pattern = ("#*"))
damaresalves.tags.top <- names(topfeatures(damaresalves.tags, 100))

# Now let us construct a FCM
damaresalves.tags.fcm <- fcm(damaresalves.tags)

# Let us make a FCM only with the top hashtags

damaresalves.top.hash <- fcm_select(damaresalves.tags.fcm, pattern = damaresalves.tags.top)

textplot_network(damaresalves.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')

#Selecting the handles
damaresalves.handle <- dfm_select(damaresalves.dfm, pattern = ("@*"))
damaresalves.handle.top <- names(topfeatures(damaresalves.handle, 100))

# Now let us construct a FCM
damaresalves.handle.fcm <- fcm(damaresalves.handle)

# Let us make a FCM only with the top handles

damaresalves.top.handles <- fcm_select(damaresalves.handle.fcm, pattern = damaresalves.handle.top)

textplot_network(damaresalves.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')


# tereza cristina 

#creating a general DFM
terezacristina.dfm <- dfm(terezacristina.toc)

#Selecting the most frequent words
terezacristina.top <- names(topfeatures(terezacristina.dfm, 30))
#Selecting the most common words to print
terezacristina.fcm <-fcm(terezacristina.dfm)
terezacristina.top.fcm <- fcm_select(terezacristina.fcm, pattern = terezacristina.top)

textplot_network(terezacristina.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')

#Selecting the hashtag
terezacristina.tags <- dfm_select(terezacristina.dfm, pattern = ("#*"))
terezacristina.tags.top <- names(topfeatures(terezacristina.tags, 100))

# Now let us construct a FCM
terezacristina.tags.fcm <- fcm(terezacristina.tags)

# Let us make a FCM only with the top hashtags

terezacristina.top.hash <- fcm_select(terezacristina.tags.fcm, pattern = terezacristina.tags.top)

textplot_network(terezacristina.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.7, 
                 edge_size = 7,
                 edge_color = 'darkgreen')

#Selecting the handles
terezacristina.handle <- dfm_select(terezacristina.dfm, pattern = ("@*"))
terezacristina.handle.top <- names(topfeatures(terezacristina.handle, 100))

# Now let us construct a FCM
terezacristina.handle.fcm <- fcm(terezacristina.handle)

# Let us make a FCM only with the top handles

terezacristina.top.handles <- fcm_select(terezacristina.handle.fcm, pattern = terezacristina.handle.top)

textplot_network(terezacristina.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.6, 
                 edge_size = 7,
                 edge_color = 'darkgreen')
