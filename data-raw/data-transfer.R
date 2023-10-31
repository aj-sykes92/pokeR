# card deck data
deck <- dplyr::bind_rows(jsonlite::read_json("data-raw/deck.json", simplifyVector = FALSE))

# write to package
usethis::use_data(deck, overwrite = TRUE, internal = TRUE)
