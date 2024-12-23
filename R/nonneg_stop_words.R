#' Non-negative stop words
#'
#' Stop word lexicons (SMART, onix, and snowball) but without negation words, i.e. negation words
#' will not be treated as stopwords. This is useful when looking for things such as non-compliance
#' in bigram analysis or topic modelling.
#'
#' @format A [tibble][tibble::tibble-package] with 1094 rows and 2 columns:
#' \describe{
#'  \item{word}{The non-negative stop word.}
#'  \item{lexicon}{The lexicon of origin: SMART, onix, or snowball.}
#' }
#' @source Derived from [tidytext::stop_words] with negation/negative terms removed.
"nonneg_stop_words"
