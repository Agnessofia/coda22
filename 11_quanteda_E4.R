writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")
# Packages ----------------------------------------------------------------
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)

# Boric

#creating a general DFM
gabrielboric.dfm <- dfm(gabrielboric.toc)

#Selecting the most frequent words
gabrielboric.top <- names(topfeatures(gabrielboric.dfm, 30))

#Selecting the most common words to print
gabrielboric.fcm <-fcm(gabrielboric.dfm)
gabrielboric.top.fcm <- fcm_select(gabrielboric.fcm, pattern = gabrielboric.top)

textplot_network(gabrielboric.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')

#Selecting the hashtag
gabrielboric.tags <- dfm_select(gabrielboric.dfm, pattern = ("#*"))
gabrielboric.tags.top <- names(topfeatures(gabrielboric.tags, 100))

# Now let us construct a FCM
gabrielboric.tags.fcm <- fcm(gabrielboric.tags)

# Let us make a FCM only with the top hashtags

gabrielboric.top.hash <- fcm_select(gabrielboric.tags.fcm, pattern = gabrielboric.tags.top)

textplot_network(gabrielboric.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')

#Selecting the handles
gabrielboric.handle <- dfm_select(gabrielboric.dfm, pattern = ("@*"))
gabrielboric.handle.top <- names(topfeatures(gabrielboric.handle, 100))

# Now let us construct a FCM
gabrielboric.handle.fcm <- fcm(gabrielboric.handle)

# Let us make a FCM only with the top handles

gabrielboric.top.handles <- fcm_select(gabrielboric.handle.fcm, pattern = gabrielboric.handle.top)

textplot_network(gabrielboric.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')


# sebastianpinera

#creating a general DFM
sebastianpinera.dfm <- dfm(sebastianpinera.toc)

#Selecting the most frequent words
sebastianpinera.top <- names(topfeatures(sebastianpinera.dfm, 30))
#Selecting the most common words to print
sebastianpinera.fcm <-fcm(sebastianpinera.dfm)
sebastianpinera.top.fcm <- fcm_select(sebastianpinera.fcm, pattern = sebastianpinera.top)

textplot_network(sebastianpinera.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')

#Selecting the hashtag
sebastianpinera.tags <- dfm_select(sebastianpinera.dfm, pattern = ("#*"))
sebastianpinera.tags.top <- names(topfeatures(sebastianpinera.tags, 100))

# Now let us construct a FCM
sebastianpinera.tags.fcm <- fcm(sebastianpinera.tags)

# Let us make a FCM only with the top hashtags

sebastianpinera.top.hash <- fcm_select(sebastianpinera.tags.fcm, pattern = sebastianpinera.tags.top)

textplot_network(sebastianpinera.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')

#Selecting the handles
sebastianpinera.handle <- dfm_select(sebastianpinera.dfm, pattern = ("@*"))
sebastianpinera.handle.top <- names(topfeatures(sebastianpinera.handle, 100))

# Now let us construct a FCM
sebastianpinera.handle.fcm <- fcm(sebastianpinera.handle)

# Let us make a FCM only with the top handles

sebastianpinera.top.handles <- fcm_select(sebastianpinera.handle.fcm, pattern = sebastianpinera.handle.top)

textplot_network(sebastianpinera.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')

