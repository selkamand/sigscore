#' Pretrained prediction model
#'
#' An S7 class representing a pretrained SigScore model used to predict
#' mechanistic dysfunctions in cancer cells from genomic and transcriptomic
#' features. `Model` objects provide a unified interface to all SigScore models
#' and encapsulate both metadata and the prediction function.
#'
#' @section Constructor:
#' `Model(name, description, disease, doi = "", fun)` creates a new pretrained
#' model object.
#'
#' @param name A scalar character string giving the unique model identifier.
#' @param description A scalar character string describing the biological task
#'   and purpose of the model.
#' @param disease A scalar character string indicating the disease context the
#'   model was trained for.
#' @param doi A scalar character string giving the DOI of the associated
#'   publication, if available.
#' @param fun A function implementing the model prediction logic. The function
#'   must accept at least a `data` argument containing the required model inputs.
#'
#' @details
#' The prediction function stored in `fun` is expected to operate on a named
#' list or similar structure matching the model specification. Validation is
#' performed at construction time to ensure the required interface is present.
#'
#'
#' @export
Model <- S7::new_class(
  "Model",
  properties = list(
    name = S7::new_property(
      class = S7::class_character,
      validator = function(value) {
        validate_scalar(value, "name")
      }
    ),
    fun = S7::new_property(
      class = S7::class_function,
      validator = function(value) {
        required <- c("data")
        argnames <- formalArgs(value)
        missing <- setdiff(required, argnames)
        if (length(missing) > 0) {
          return(sprintf(
            "Model function is missing required argument/s: [%s]",
            toString(missing)
          ))
        }
      }
    ),
    description = S7::new_property(
      class = S7::class_character,
      validator = function(value) {
        validate_scalar(value, "description")
      }
    ),
    disease = S7::new_property(
      class = S7::class_character,
      validator = function(value) {
        validate_scalar(value, "disease")
      }
    ),
    doi = S7::new_property(
      class = S7::class_character,
      validator = function(value) {
        validate_scalar(value, "doi")
      }
    )
  ),
  constructor = function(name, description, disease, doi = "", fun) {
    S7::new_object(
      S7::S7_object(),
      name = name,
      description = description,
      disease = disease,
      doi = doi,
      fun = fun
    )
  }
)

# Collection of Models ---------------------
#' Collection of pretrained models
#'
#' An S7 class representing a collection of pretrained SigScore
#' [`Model`] objects. `ModelCollection` is used as a lightweight container
#' for grouping and managing multiple prediction models under a unified
#' interface.
#'
#' @section Constructor:
#' `ModelCollection(models)` creates a new collection of pretrained models.
#'
#' @param models A named or unnamed list of [`Model`] objects.
#'
#' @details
#' All elements of `models` must inherit from the [`Model`] class.
#' Validation is performed at construction time to ensure type safety.
#'
#' @seealso [Model], [sig_available_models()]
#'
#' @export
ModelCollection <- S7::new_class(
  name = "ModelCollection",
  properties = list(
    models = S7::new_property(
      class = S7::class_list,
      validator = function(value) {
        correct_class <- vapply(
          X = value,
          FUN = function(x) {
            inherits(x, "sigscore::Model")
          },
          FUN.VALUE = logical(1)
        )
        if (!all(correct_class)) {
          return(sprintf("All models must belong to sigscore::Model class"))
        }
        return(NULL)
      }
    )
  ),
  constructor = function(models) {
    S7::new_object(
      .parent = S7::S7_object,
      models = models
    )
  }
)

# Utilities ---------------------
validate_scalar <- function(value, argname) {
  if (length(value) != 1) {
    return(sprintf("%s must have a length of 1, not %s", argname, length(value)))
  }
  return(NULL)
}
