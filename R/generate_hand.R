#' @title Generate a single Texas Hold'Em hand
#' @description Randomly generate a Texas Hold'Em poker hand, with optional arguments to tailor
#' number of players, known player hand(s), and known community cards.
#' @param players Integer scalar, number of players. Must be less than 10.
#' @param known_p List of lists of length 2, containing card IDs representing known player hands.
#' @param known_c List of length 0 to 5, containing card IDs representing known community cards.
#' @import dplyr tidyr purrr
generate_hand <- function(players, known_p, known_c) {

  # extract known player hands and community cards
  known <- bind_rows(
    tibble(player = 0L, id = as.character(known_c)),
    imap_dfr(known_p, ~tibble(id = as.character(.x), player = .y))
  ) %>%
    left_join(deck, by = "id")

  # extract unknown hands and community cards
  unknown_n <- c(
    c(rep(0L, 5L - length(known_c))), # unknown community cards
    rep(length(known_p) + seq_len(players - length(known_p)), each = 2L) # unknown player cards
  )

  unknown <- deck %>%
    anti_join(known, by = "id") %>%
    sample_n(length(unknown_n), replace = FALSE) %>%
    mutate(player = unknown_n, .before = 1L)

  # join
  hand <- bind_rows(list(known = known, unknown = unknown), .id = "kind") %>%
    arrange(.data$player)

  return(hand)
}
