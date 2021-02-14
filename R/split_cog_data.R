
# split and compute means by group
split_data <- function(data, domain, pheno, ...) {
  do.call(rbind, lapply(split(data, data$domain, pheno), function(d) {
    data.frame(
      mean = mean(d$pheno),
      sd = sd(d$pheno),
      domain = d$domain
    )
  }))
}

split_data_frame <- function(rbind, df) {
  ds <- do.call(rbind, lapply(split(df, df$gp), function(d) {
    data.frame(mean = mean(d$y), sd = sd(d$y), gp = d$gp)
  }))
}
