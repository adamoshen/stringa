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
#' @rdname string-preview
#' @export
#' @seealso [stringr::str_trunc()], which this function wraps.
str_head <- function(string, width=NULL, ellipsis="...") {
  check_number_whole(width, allow_null=TRUE)

  width <- width %||% get_width(string, ellipsis)

  stringr::str_trunc(string, width, side="right", ellipsis)
}
#'
#' @rdname string-preview
#' @export
str_tail <- function(string, width=NULL, ellipsis="...") {
  check_number_whole(width, allow_null=TRUE)

  width <- width %||% get_width(string, ellipsis)

  stringr::str_trunc(string, width, side="left", ellipsis)
}

get_width <- function(string, ellipsis) {
  ceiling(max(stringr::str_length(string))) / 10
}
