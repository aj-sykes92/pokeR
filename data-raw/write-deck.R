library(tidyverse)

# build deck
suit <- rep(c("h", "d", "s", "c"), each = 13L)
number <- rep(1L:13L, times = 4L)
value <- rep(c(14L, 2L:13L), times = 4L)

deck <- pmap(list(suit, number, value), ~list(
  id = paste0(..1, str_pad(..2, 2L, "left", "0")),
  suit = ..1,
  value = ..3
))

# write out
jsonlite::write_json(deck, "data-raw/deck.json", auto_unbox = TRUE, pretty = TRUE, na = "null", null = "null")
