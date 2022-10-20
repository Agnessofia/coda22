a.tk <- tokens(a.lula_Ciro,
               remove_punct = TRUE,
               remove_symbols = TRUE,
               remove_numbers = TRUE,
               verbose = TRUE) %>%
  tokens_remove(pattern = stopwords("pt")) %>%
  tokens_group(groups = screen_name)
writeLines("It is part of my CNPq-funded project and seeks to make corpus tools and R accessible. If you have any doubts or wish to make any research contact please send me an email. Rodrigo de Lima-Lopes rll307@unicamp.br")

textstat_keyness(dfm.pres,
                 target = "gabrielboric",
                 measure = "lr") |> 
  textplot_keyness(n= 25)