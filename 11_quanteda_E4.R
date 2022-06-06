writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")
# Packages ----------------------------------------------------------------
library(quanteda)
library(quanteda.textplots)
library(quanteda.textstats)

# Lula

#creating a general DFM
Lula.dfm <- dfm(lula.toc)

#Selecting the most frequent words
Lula.top <- names(topfeatures(Lula.dfm, 30))
#Selecting the most common words to print
Lula.fcm <-fcm(Lula.dfm)
Lula.top.fcm <- fcm_select(Lula.fcm, pattern = Lula.top)

textplot_network(Lula.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')

#Selecting the hashtag
Lula.tags <- dfm_select(Lula.dfm, pattern = ("#*"))
Lula.tags.top <- names(topfeatures(Lula.tags, 100))

# Now let us construct a FCM
Lula.tags.fcm <- fcm(Lula.tags)

# Let us make a FCM only with the top hashtags

Lula.top.hash <- fcm_select(Lula.tags.fcm, pattern = Lula.tags.top)

textplot_network(Lula.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')

#Selecting the handles
Lula.handle <- dfm_select(Lula.dfm, pattern = ("@*"))
Lula.handle.top <- names(topfeatures(Lula.handle, 100))

# Now let us construct a FCM
Lula.handle.fcm <- fcm(Lula.handle)

# Let us make a FCM only with the top handles

Lula.top.handles <- fcm_select(Lula.handle.fcm, pattern = Lula.handle.top)

textplot_network(Lula.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')

# SAVING AS A MATRIX FOR GEPHI
Lula.hash.matrix <- convert(Lula.top.hash,to = "matrix")
write.csv(Lula.hash.matrix,"LulaHash.csv")

Lula.handles.matrix <- convert(Lula.top.handles,to = "matrix")
write.csv(Lula.handles.matrix,"LulaHandle.csv")

# Ciro

#creating a general DFM
Ciro.dfm <- dfm(ciro.toc)

#Selecting the most frequent words
Ciro.top <- names(topfeatures(Ciro.dfm, 30))
#Selecting the most common words to print
Ciro.fcm <-fcm(Ciro.dfm)
Ciro.top.fcm <- fcm_select(Ciro.fcm, pattern = Ciro.top)

textplot_network(Ciro.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')

#Selecting the hashtag
Ciro.tags <- dfm_select(Ciro.dfm, pattern = ("#*"))
Ciro.tags.top <- names(topfeatures(Ciro.tags, 100))

# Now let us construct a FCM
Ciro.tags.fcm <- fcm(Ciro.tags)

# Let us make a FCM only with the top hashtags

Ciro.top.hash <- fcm_select(Ciro.tags.fcm, pattern = Ciro.tags.top)

textplot_network(Ciro.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')

#Selecting the handles
Ciro.handle <- dfm_select(Ciro.dfm, pattern = ("@*"))
Ciro.handle.top <- names(topfeatures(Ciro.handle, 100))

# Now let us construct a FCM
Ciro.handle.fcm <- fcm(Ciro.handle)

# Let us make a FCM only with the top handles

Ciro.top.handles <- fcm_select(Ciro.handle.fcm, pattern = Ciro.handle.top)

textplot_network(Ciro.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')

# SAVING AS A MATRIX FOR GEPHI
Ciro.hash.matrix <- convert(Ciro.top.hash,to = "matrix")
write.csv(Ciro.hash.matrix,"CiroHash.csv")

Ciro.handles.matrix <- convert(Ciro.top.handles,to = "matrix")
write.csv(Ciro.handles.matrix,"CiroHandle.csv")

# JB

#creating a general DFM
JB.dfm <- dfm(JB.toc)

#Selecting the most frequent words
JB.top <- names(topfeatures(JB.dfm, 30))
#Selecting the most common words to print
JB.fcm <-fcm(JB.dfm)
JB.top.fcm <- fcm_select(JB.fcm, pattern = JB.top)

textplot_network(JB.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'blue')

#Selecting the hashtag
JB.tags <- dfm_select(JB.dfm, pattern = ("#*"))
JB.tags.top <- names(topfeatures(JB.tags, 100))

# Now let us construct a FCM
JB.tags.fcm <- fcm(JB.tags)

# Let us make a FCM only with the top hashtags

JB.top.hash <- fcm_select(JB.tags.fcm, pattern = JB.tags.top)

textplot_network(JB.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'blue')

#Selecting the handles
JB.handle <- dfm_select(JB.dfm, pattern = ("@*"))
JB.handle.top <- names(topfeatures(JB.handle, 100))

# Now let us construct a FCM
JB.handle.fcm <- fcm(JB.handle)

# Let us make a FCM only with the top handles

JB.top.handles <- fcm_select(JB.handle.fcm, pattern = JB.handle.top)

textplot_network(JB.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'blue')

# SAVING AS A MATRIX FOR GEPHI
JB.hash.matrix <- convert(JB.top.hash,to = "matrix")
write.csv(JB.hash.matrix,"JBHash.csv")

JB.handles.matrix <- convert(JB.top.handles,to = "matrix")
write.csv(JB.handles.matrix,"JBHandle.csv")