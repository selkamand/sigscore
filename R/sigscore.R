#' List available pretrained models
#'
#' Prints a table of all pretrained SigScore models available in the package.
#'
#' @return Invisibly returns a data frame describing available models.
#'
#' @export
sig_available_models <- function() {
  # Read List of Models
  path <- system.file(package = "sigscore", "models.csv")
  data <- utils::read.csv(path)

  # Print Dataframe
  print(data)
}
