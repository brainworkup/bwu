# Generate some sample data, then compute mean and standard deviation
# in each group
df <- data.frame(
    gp = factor(rep(letters[1:3], each = 10)),
    y = rnorm(30)
  )
ds <- do.call(rbind, lapply(split(df, df$gp), function(d) {
    data.frame(mean = mean(d$y), sd = sd(d$y), gp = d$gp)
  }))

# The summary data frame ds is used to plot larger red points on top
# of the raw data. Note that we don't need to supply `data` or `mapping`
# in each layer because the defaults from ggplot() are used.
ggplot(df, aes(gp, y)) +
    geom_point() +
    geom_point(data = ds, aes(y = mean), colour = 'red', size = 3)

  # Same plot as above, declaring only the data frame in ggplot().
  # Note how the x and y aesthetics must now be declared in
  # each geom_point() layer.
ggplot(df) +
    geom_point(aes(gp, y)) +
    geom_point(data = ds, aes(gp, mean), colour = 'red', size = 3)

  # Alternatively we can fully specify the plot in each layer. This
  # is not useful here, but can be more clear when working with complex
  # mult-dataset graphics
ggplot() +
    geom_point(data = df, aes(gp, y)) +
    geom_point(data = ds, aes(gp, mean), colour = 'red', size = 3) +
    geom_errorbar(
      data = ds,
      aes(gp, mean, ymin = mean - sd, ymax = mean + sd),
      colour = 'red',
      width = 0.4
    )

##
name <- function(variables) {

}
memory <- purrr::pluck(neurocog1, 7, attr_getter("Memory"))
purrr::get_rownames(neurocog1)

get_rownames <- attr_getter("row.names")
get_rownames(neurocog1)

cog.f <- neurocog1
cog.f <- cog.f %>% dplyr::mutate(gp = domain)

cog.d <- split_data_frame(neurocog1, domain, z)

# split and compute means by group
cog.d <- do.call(rbind, lapply(split(cog.f, cog.f$domain), function(d) {
  data.frame(mean = mean(d$z), sd = sd(d$z), gp = d$domain)
}))

cog.ds <- do.call(rbind, lapply(split(cog.f, cog.f$subdomain), function(d) {
  data.frame(mean = mean(d$z), sd = sd(d$z), gp = d$subdomain)
}))

cog.dsn <- do.call(rbind, lapply(split(cog.f, cog.f$subdomain_narrow), function(d) {
  data.frame(mean = mean(d$z), sd = sd(d$z), gp = d$subdomain_narrow)
}))

library(munsell)
my_blue <- "5PB 5/8"

plot <- function(domain, mean) {

}

ggplot() +
  geom_segment(data = cog.d, aes(x = mean, y = reorder(gp, mean), xend = 0, yend = gp), size = 1) +
  geom_point(data = cog.f, aes(x = z, y = reorder(domain, z)), shape = 21, size = 2, color = "orange", fill = "black") +
  geom_point(data = cog.d, aes(x = mean, y = reorder(gp, mean)), shape = 21, size = 8, color = "black", fill = "orange") +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(colour = "white"))

ggplot() +
  geom_segment(data = cog.ds, aes(x = mean, y = reorder(gp, mean), xend = 0, yend = gp), size = 1) +
  geom_point(data = cog.f, aes(x = z, y = reorder(subdomain, z)), shape = 21, size = 2, color = "orange", fill = "black") +
  geom_point(data = cog.ds, aes(x = mean, y = reorder(gp, mean)), shape = 21, size = 8, color = "black", fill = "orange") +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(colour = "white"))

ggplot() +
  geom_segment(data = cog.dsn, aes(x = mean, y = reorder(gp, mean), xend = 0, yend = gp), size = 1) +
  geom_point(data = cog.f, aes(x = z, y = reorder(subdomain_narrow, z)), shape = 21, size = 4, color = "orange", fill = "gray") +
  geom_point(data = cog.dsn, aes(x = mean, y = reorder(gp, mean)), shape = 21, size = 8, color = "black", fill = "orange") +
  theme_fivethirtyeight() +
  theme(panel.background = element_rect(fill = "white")) +
  theme(plot.background = element_rect(fill = "white")) +
  theme(panel.border = element_rect(colour = "white"))




