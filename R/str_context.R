str_context <- function(string, pattern, width=NULL, ellipsis="...") {
  # perform check that pattern is character of length 1
  # perform check that width is a single positive number
  # perform check that ellipsis is character of length 1
  # --- Build list of context strings
  context <- stringr::str_locate_all(string, pattern)
  context <- purrr::map(context, \(context) purrr::array_branch(context, margin=2))
  context <- purrr::map2(
    context, string,
    \(context, string) purrr::assign_in(context, "string_length", stringr::str_length(string))
  )

  context <- purrr::map(
    context,
    \(context) purrr::assign_in(context, "string_length", rep_num(context$string_length, length(context$start)))
  )

  context <- purrr::map_if(
    context,
    \(context) sum(lengths(purrr::list_flatten(context))) != 0,
    \(context) purrr::pmap(
      purrr::list_flatten(context),
      \(start, end, string_length) expand_match(start, end, string_length, width)
    ),
    .else = \(context) purrr::list_c(context)
  )
  # [TODO] Incorporate ellipses somewhere around here
  context <- purrr::set_names(context, string)
  context <- purrr::imap(
    context,
    \(context, string) purrr::modify_tree(context, leaf = \(bounds) str_extract_sub(string, bounds))
  )

  context <- unname(context)

  # [TODO] Highlight pattern
}

rep_num <- function(x, times) {
  if (times <= 0) {
    integer(0)
  } else {
    rep(x, times=times)
  }
}

expand_match <- function(start, end, string_length, width) {
  remaining_width <- width - (end - start + 1)

  if (remaining_width <= 0) {
    c("start" = start, "end" = end)
  }  else if (start == 1L) {
    c("start" = 1L, "end" = min(string_length, end + remaining_width))
  } else if (end == string_length) {
    c("start" = max(1L, start - remaining_width), "end" = string_length)
  } else {
    c("start" = max(1L, start - remaining_width %/% 2),
      "end" = min(string_length, end + remaining_width %/% 2))
  }
}

str_extract_sub <- function(string, boundaries) {
  if (length(boundaries) == 0) {
    NA
  } else {
    rlang::inject(stringr::str_sub(string, !!!as.list(boundaries)))
  }
}
