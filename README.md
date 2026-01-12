
<!-- README.md is generated from README.Rmd. Please edit that file -->

# sigscore

<!-- badges: start -->

<!-- badges: end -->

SigScore predicts mechanistic dysfunctions in cancer cells from genomic
and transcriptomic features.

SigScore provides a unified interface to all models

## Installation

You can install the development version of sigscore like so:

``` r
pak::pak("selkamand/sigscore")
```

## Quick Start

``` r
library(sigscore)

# List available models
sig_available_models()

# Describe a model of interest
sig_describe_model("paed_genomic_tp53")

# Run the model
# (data is a list with named elements corresponding
# to inputs required by model specification)
sig_score(
  model = paed_genomic_tp53,
  data = example_p53_dataset
)
```
