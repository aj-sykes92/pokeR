#' @title Wrapper function to plumb package and expose API endpoints
#' @param ... Arguments to pass to \code{plumber::pr_run}.
#' @import plumber purrr
#' @export
pr.plumb_package <- function(...) {

  # create plumber object
  pr <- plumber::pr(system.file("plumber", "plumber.R", package = "pokeR"))

  # add post request examples from package data
  # pr$setApiSpec(pr.add_examples)

  # add documentation
  pr$setDocs(docs = "swagger")

  # list args
  args <- append(
    list(pr = pr),
    list(...)
  )

  # plumb
  do.call(plumber::pr_run, args)
}
