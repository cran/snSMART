% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/BJSM_c.R
\name{BJSM_c}
\alias{BJSM_c}
\alias{summary.BJSM_c}
\alias{print.summary.BJSM_c}
\alias{print.BJSM_c}
\title{BJSM continuous (snSMART with three active treatments and a continuous outcome design)}
\usage{
BJSM_c(
  data,
  xi_prior.mean,
  xi_prior.sd,
  phi3_prior.sd,
  n_MCMC_chain,
  n.adapt,
  MCMC_SAMPLE,
  ci = 0.95,
  n.digits,
  thin = 1,
  BURN.IN = 100,
  jags.model_options = NULL,
  coda.samples_options = NULL,
  verbose = FALSE,
  ...
)

\method{summary}{BJSM_c}(object, ...)

\method{print}{summary.BJSM_c}(x, ...)

\method{print}{BJSM_c}(x, ...)
}
\arguments{
\item{data}{trial ddatset with columns: \code{id, trt1} (treatment 1), \code{stage1outcome, stay}
(stay = 1 if patient stay on the same treatment in stage 2, otherwise stay = 0),
\code{trt2} (treatment 2), \code{stage2outcome}}

\item{xi_prior.mean}{a 3-element vector of mean of the prior distributions
(normal distribution) for \code{xi}s (treatment effect). Please check the \code{Details}
section for more explaination}

\item{xi_prior.sd}{a 3-element vector of standard deviation of the prior distributions
(normal distribution) for \code{xi}s (treatment effect). Please check the \code{Details}
section for more explaination}

\item{phi3_prior.sd}{standard deviation of the prior distribution (folded normal
distribution) of \code{phi3} (if the patient stays on the same treatment, \code{phi3}
is the cumulative effect of stage 1 that occurs on the treatment longer term).
Please check the \code{Details} section for more explaination}

\item{n_MCMC_chain}{number of MCMC chains, default to 1}

\item{n.adapt}{the number of iterations for adaptation}

\item{MCMC_SAMPLE}{number of iterations for MCMC}

\item{ci}{coverage probability for credible intervals, default = 0.95}

\item{n.digits}{number of digits to keep in the final estimation of treatment effect}

\item{thin}{thinning interval for monitors}

\item{BURN.IN}{number of burn-in iterations for MCMC}

\item{jags.model_options}{a list of optional arguments that are passed to \code{jags.model()} function.}

\item{coda.samples_options}{a list of optional arguments that are passed to \code{coda.samples()} function.}

\item{verbose}{TRUE or FALSE. If FALSE, no function message and progress bar will be
printed.}

\item{...}{further arguments. Not currently used.}

\item{object}{object to summarize.}

\item{x}{object to print}
}
\value{
\item{posterior_sample}{an \code{mcmc.list} object generated through the \code{coda.samples()} function,
which includes posterior samples of the link parameters and response rates generated through the MCMC
process}
\item{mean_estimate}{BJSM estimate of each parameter:
\enumerate{
\item \code{phi1} - lingering effect of the first treatment
\item \code{phi3} - if the patient stays on the same treatment, \code{phi3} is the cumulative effect of stage 1 that occurs on the treatment longer term
\item \code{xi_j} - the expected effect of treatment j, j = 1, 2, 3 in the first stage
\item \code{V1},\code{V2} are the variance-covariance matrix of the multivariate distribution. \code{V1} is for patients who stay on the same treatment,
and \code{V2} is for patients who switch treatments. This allows those who stay on the same treatment to have a different correlation between stage one
stage two outcomes than those who switch treatments.
}}
\item{ci_estimate}{x\% credible interval for each parameter. By default round to
2 decimal places, if more decimals are needed, please access the results by
\verb{[YourResultName]$ci_estimates$CI_low} or \verb{[YourResultName]$ci_estimates$CI_high} }
}
\description{
BJSM (Bayesian Joint Stage Modeling) method that borrows information across both stages
to estimate the individual response rate of each treatment (with continuous
outcome and a mapping function).
}
\details{
section 2.2.1 and 2.2.2 of the paper listed under \code{reference} provides a detailed
description of the assumptions and prior distributions of the model.

Note that this package does not include the JAGS library, users need to install JAGS separately. Please check this page for more details: \url{https://sourceforge.net/projects/mcmc-jags/}
}
\examples{
trialData <- trialDataMF

BJSM_result <- BJSM_c(
  data = trialData, xi_prior.mean = c(50, 50, 50),
  xi_prior.sd = c(50, 50, 50), phi3_prior.sd = 20, n_MCMC_chain = 1,
  n.adapt = 1000, MCMC_SAMPLE = 5000, BURIN.IN = 1000, ci = 0.95, n.digits = 5, verbose = FALSE
)

summary(BJSM_result)
print(BJSM_result)
}
\references{
Hartman, H., Tamura, R.N., Schipper, M.J. and Kidwell, K.M., 2021. Design and analysis considerations for utilizing a mapping function in a small sample,
sequential, multiple assignment, randomized trials with continuous outcomes. Statistics in Medicine, 40(2), pp.312-326. URL: \url{doi:10.1002/sim.8776}
}
