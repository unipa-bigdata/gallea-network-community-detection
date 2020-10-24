library(ggplot2)

confidencePlot <- function(result.vector, measure, nsim) {

  d <- lapply(result.vector, "[", c(measure))
  d1 <- matrix(unlist(d), nrow = ntests, byrow = TRUE)
  means <- colMeans(d1)
  mod.max <- apply(d1, 2, max, na.rm = TRUE)
  mod.min <- apply(d1, 2, min, na.rm = TRUE)
  dev <- apply(d1, 2, sd, na.rm = TRUE)
  data <- t(rbind(means, mod.max, mod.min))


  data.f <- data.frame("max" = mod.max, "min" = mod.min, "mean" = means, "range" = 1:nsim, "type" = "Modularity")

  # Make the plot
  ggplot(data = data.f, aes(x = range, y = mean, ymin = min, ymax = max, fill = type, linetype = type)) +
    geom_line() +
    geom_ribbon(alpha = 0.5) +
    xlab('Current step') +
    ylab("Modularity")
}