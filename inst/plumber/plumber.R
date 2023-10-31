#* @apiTitle PokeR API endpoints
#* @apiDescription Random simulation of poker hands.

# AUTHENTICATION

# plumber::options_plumber(
#   sharedSecret = Sys.getenv("PLUMBER_SHARED_SECRET")
# )

# POST requests

#* Generate Texas Hold'Em hands.
#* Send optional parameters for number hands, number of players, and known cards and receive
#* randomly generated poker hands.
#* @parser json list(simplifyVector = FALSE)
#* @serializer unboxedJSON list(null = "null", na = "null")
#* @param n:int
#* @param players:int
#* @param known_p:object
#* @param known_c:object
#* @param seed:int
#* @post /api/generate_hands
function(n = 1L, players = 4L, known_p = list(), known_c = list(), seed = NULL) {
  pokeR::generate_hands(n, players, known_p, known_c, seed)
}

#* Test POST function
#* @parser json list(simplifyVector = FALSE)
#* @serializer unboxedJSON list(null = "null", na = "null")
#* @param test:object
#* @post /api/test_post
function(test) {
  return(test)
}


# GET requests

#* Echo back the input
#* @param msg The message to echo
#* @get /api/msg
function(msg = "") {
  list(msg = paste0("The message is: '", msg, "'"))
}
