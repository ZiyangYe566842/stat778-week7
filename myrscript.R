#!/usr/bin/env Rscript

user_lib <- "~/Rlibs"
if (!dir.exists(user_lib)) {
  dir.create(user_lib, recursive = TRUE)
}
.libPaths(c(user_lib, .libPaths()))


install_if_missing <- function(pkg) {
  if (!suppressWarnings(require(pkg, character.only = TRUE))) {
    message("Package ", pkg, " not found. Installing...")
    install.packages(pkg, repos = "https://cloud.r-project.org", lib = user_lib)
    library(pkg, character.only = TRUE)
  }
}

install_if_missing("argparser")
install_if_missing("robustbase")


suppressPackageStartupMessages({
  library(argparser)
})
p <- arg_parser("Estimate AR(1) correlation coefficient using MCD")
p <- add_argument(p, "--ncores", help="Number of cores (not used in this script)", type="integer", default=1)
p <- add_argument(p, "--repl", help="Number of replications", type="integer", default=10)
p <- add_argument(p, "--task", help="Task number (1-10) for AR(1) coefficient grid", type="integer", default=1)
argv <- parse_args(p)

grid <- seq(0.09, 0.99, length.out = 10)
rho <- grid[argv$task]
cat("Using AR(1) coefficient (rho) =", rho, "\n")

d <- 200

corr_matrix <- outer(1:d, 1:d, FUN = function(i, j) rho^abs(i - j))

L <- chol(corr_matrix)


n <- 400
results_list <- vector("list", argv$repl)
set.seed(123)

for (rep in 1:argv$repl) {

  X <- matrix(rt(n * d, df = 2), nrow = n, ncol = d)

  Y <- X %*% t(L)
  

  mcd <- covMcd(Y)
  corr_est <- cov2cor(mcd$cov)

  first_superdiag <- sapply(1:(d - 1), function(i) corr_est[i, i + 1])
  results_list[[rep]] <- first_superdiag
}


saveRDS(results_list, file = "myrscript.rds")
cat("Results saved to myrscript.rds\n")

