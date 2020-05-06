
<!-- README.md is generated from README.Rmd. Please edit that file -->

# The MCE package <a href='https:/jack-h-laverick.github.io/MCE'><img src='man/figures/logo.png' align="right" height="139" /></a>

<!-- badges: start -->

<!-- badges: end -->

MCE is an R package for modelling the vertical distribution of coral
communities across depth gradients. MCE currently contains a light
driven mechanistic model of the transition from shallow to mesophotic
reefs. The goal for the future is to allow the research community to
include additional mechanisms. These models can provide useful null
hypotheses, and help us to quantify the importance of missing ecosystem
level processes.

## Installation

You can install the latest version of MCE from
[GitHub](https://github.com/) with:

``` r
remotes::install_github("Jack-H-Laverick/MCE")
```

## Usage

The functions in MCE are broadly split into environmental functions, and
community preferences. By combining the spatial gradient of an
environmental factor with a relationship between the factor and coral
communities, we can predict community zonation for a reef.

<img src="man/figures/README-plot-1.png" width="100%" style="display: block; margin: auto;" />

## Future Expansion

The first version of MCE contains a simple light-relationship, including
changes in water clarity and bathymetric shading. There are other
enviornmental gradients and processes which could affect the vertical
zonation of coral reef communities.

<br> To read more on future opportunities for expansion, go to
“Contribute”. Get in touch if your pet process is missing from the
list, or if you think you have data to help characterise a new
relationship.
