#' Bind document count using inverse document frequency
#'
#' Bind the count of the number of documents where a term occurs. The `tbl` argument is assumed to
#' be the output of a call to `tidytext::bind_tf_idf()`. This can be useful when filtering for noise
#' words that should be excluded from downstream analyses for not appearing in enough documents in a
#' corpus.
#'
#' @param tbl A data frame, typically obtained from a call to `tidytext::bind_tf_idf()`.
#' @param document Column containing document identifiers, as a string or symbol.
#' @param idf Column containing the inverse document frequencies, as a string or symbol.
#' @export
bind_doc_count <- function(tbl, document, idf) {
  corpus_size <- dplyr::pull(tbl, {{ document }})
  corpus_size <- length(unique(corpus_size))

  dplyr::mutate(tbl, doc_count = corpus_size / exp({{ idf }}))
}
