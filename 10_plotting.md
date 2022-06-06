By Rodrigo Esteves de Lima Lopes *Campinas University* [rll307\@unicamp.br](mailto:rll307@unicamp.br)

------------------------------------------------------------------------

# Plotting

# Introduction

Our may objective here is to plot the results we collected last script. The grammar of plotting might be a bit overwhelming, but keep in mind it is just a small introduction.

In this tutorial we use [`ggplot2`](https://ggplot2.tidyverse.org/index.html), a package for plotting in R. Other packages should do the job, but `ggplot2` is the most popular across `R` users.

Plotting: 

``` r
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
```

![Lula vs Ciro](images/lulaVSciro.png)

![Lula vs Bolsonaro](images/lulavsJB.png)

![Ciro vs Bolsonaro](images/ciroVSjb.png)
