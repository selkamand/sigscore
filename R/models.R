#' Fetch all pretrained models
sig_pretrained_models <- function() {
  ModelCollection(
    models = list(
      # Paed Wilms P53 deficiency detection
      Model(
        name = "p53_wilms",
        description =
          "Predicts P53 deficiency in paediatric Wilms tumours
          based on genome-wide instability. Nearest neighbour approach.
          ",
        doi = "",
        disease = "Paediatric Wilms Tumours",
        fun = predict_p53_wilms,
      )
    )
  )
}


predict_p53_wilms <- function(data, refdata = system.file(package = "sigscore", "p53_wilms.csv")) {
  loh <- data$loh
  svs <- data$svs

  refdata <- read.csv(refdata)
}
