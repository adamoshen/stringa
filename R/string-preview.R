#' Preview string beginnings and ends
#'
#' Use `str_head()` to view the beginning of a string and `str_tail()` to view the end of a string.
#' These functions work better for longer strings.
#'
#' @param string A character vector of strings to preview.
#' @param width A single integer for the number of characters to show, without consideration for the
#' length of `ellipsis`. If not supplied, defaults to the length of the longest string in `string`
#' divided by 10 and rounded up to the nearest integer.
#' @param ellipsis A single string used to indicate that content has been removed.
#' @return A character vector the same length as `string`.
#' @examples
#' # Basic usage
#' str_head(paste0(letters, collapse=""))
#' str_tail(paste0(letters, collapse=""))
#'
#' # Slightly more realistic usage
#' library(tibble)
#' library(dplyr)
#' library(stringi)
#'
#' my_docs <- tibble(
#'   doc_id = stri_rand_strings(4, length=6),
#'   text = rep(4, 4)
#' ) %>%
#' mutate(text = stri_rand_lipsum(text, start_lipsum=FALSE))
#'
#' my_docs %>%
#'   pull(text, name=doc_id) %>%
#'   str_head()
#'
#' my_docs %>%
#'   pull(text, name=doc_id) %>%
#'   str_tail()
#' @rdname string-preview
#' @export
#' @seealso [stringr::str_trunc()], which this function wraps.
str_head <- function(string, width=NULL, ellipsis="...") {
  check_number_whole(width, allow_null=TRUE)

  width <- width %||% get_width(string, ellipsis)

  stringr::str_trunc(string, width, side="right", ellipsis)
}

#' @rdname string-preview
#' @export
str_tail <- function(string, width=NULL, ellipsis="...") {
  check_number_whole(width, allow_null=TRUE)

  width <- width %||% get_width(string, ellipsis)

  stringr::str_trunc(string, width, side="left", ellipsis)
}

get_width <- function(string, ellipsis) {
  ceiling(max(stringr::str_length(string)) / 10)
}
