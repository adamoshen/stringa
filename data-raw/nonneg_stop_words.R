library(tibble)
library(dplyr)
library(tidytext)

negative_words <- as_tibble_col(
  c(
  "against", "ain't", "aren't", "can't", "cannot", "cant", "couldn't", "didn't", "doesn't", "don't",
  "hadn't", "hasn't", "haven't", "isn't", "mustn't", "no", "non", "none", "nor", "not", "problem",
  "problems", "shan't", "shouldn't", "wasn't", "weren't", "without", "won't", "wouldn't"
  ),
  column_name = "word"
)

nonneg_stop_words <- anti_join(stop_words, negative_words, by="word")

usethis::use_data(nonneg_stop_words, overwrite = TRUE)
