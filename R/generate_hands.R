#' @title Generate a single Texas Hold'Em hand
#' @description Randomly generate a Texas Hold'Em poker hand, with optional arguments to tailor
#' number of hands, number of players, known player hand(s), known community cards, and the random
#' number generator seed.
#' @param n Integer scalar, number of hands. Defaults to 1.
#' @param players Integer scalar, number of players. Must be less than 10. Defaults to 4.
#' @param known_p List of lists of length 2, containing card IDs representing known player hands.
#' Defaults to empty i.e. all hands unknown.
#' @param known_c List of length 0 to 5, containing card IDs representing known community cards.
#' Default to empty i.e. all community cards unknown.
#' @param seed Integer scalar, seed for random number generator. Passed to \code{set.seed}. Defaults
#' to \code{NULL}.
#' @import purrr
#' @export
generate_hands <- function(n = 1L, players = 4L, known_p = list(), known_c = list(), seed = NULL) {

  # checks
  combine_known <- as.character(append(reduce(known_p, append, .init = list()), known_c))
  deck_ids <- deck$id
  if (!isTRUE(all(combine_known %in% deck_ids))) return("Invalid IDs in [fix_p] or [fix_c]. Please check!") #nolint
  if (!isTRUE(identical(unique(combine_known), combine_known))) return("Duplicate IDs in [fix_p] or [fix_c]. Please check!") #nolint
  if (length(known_p) > players | players > 10) return("Too many players! Did you add too many known hands?") #nolint
  if (n > 10 ^ 4) return("Too many hands. Parameter [n] must be less than 10,000.")

  # set seed
  if (isFALSE(is.null(seed))) set.seed(seed)

  # generate hands
  hands <- map(seq_len(n), possibly(~generate_hand(players, known_p, known_c), otherwise = NULL))

  return(list(hands = hands))
}
