By Rodrigo Esteves de Lima Lopes *Campinas University* [rll307\@unicamp.br](mailto:rll307@unicamp.br)

------------------------------------------------------------------------

# Plotting

# Introduction

Our may objective here is to plot the results we collected last script. The grammar of plotting might be a bit overwhelming, but keep in mind it is just a small introduction.

In this tutorial we use [`ggplot2`](https://ggplot2.tidyverse.org/index.html), a package for plotting in R. Other packages should do the job, but `ggplot2` is the most popular across `R` users.

Plotting:

``` r
textplot_network(Lula.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')
```

![Lula's 30 most frequent words](images/LulaWords.png)

``` r
textplot_network(Lula.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')
```

![Lula's most common hashtags](images/LulaHash.png)

``` r
textplot_network(Lula.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'red')
                 
```

![Lula's most quoted and re-tweeted handles](images/LulaHandles.png)

``` r
textplot_network(Ciro.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')
```

![Ciro Gome's most common words](images/CiroWords.png)

``` r
textplot_network(Ciro.top.hash, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')
```

![Ciro Gome's most common hashtags](images/CiroHash.png)

``` r
textplot_network(Ciro.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'darkgreen')
```

![Ciro Gome's most quoted/re-tweeted handles](images/CiroHandles.png)

``` r
textplot_network(JB.top.fcm, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'blue')
```

![Jair Bolsonaro's most common words](images/JBWords.png)

``` r
textplot_network(JB.top.hash, 
                min_freq = 0.1, 
                edge_alpha = 0.5, 
                edge_size = 5,
                edge_color = 'blue')
```

![Jair Bolsonaro's most common hashtags](images/JBHash.png)

``` r
textplot_network(JB.top.handles, 
                 min_freq = 0.1, 
                 edge_alpha = 0.5, 
                 edge_size = 5,
                 edge_color = 'blue')
```

![Jair Bolsonaro's most quoted/re-tweeted handles](images/JBHandles.png)
