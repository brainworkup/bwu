domain_z <- function(data = neurocog, domain = domain, z = z, mean, sd) {
  domain_z <- neurocog %>%
    group_by(domain) %>%
    summarize(across(z, c(mean, sd)))
}


mtcars
