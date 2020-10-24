library(tidyverse)
library(hrbrthemes)
library(viridis)

boxPlot <- function(result.vector, ntests) {

  d <- lapply(result.vector, "[", c("max.modularity"))
  d1 <- matrix(unlist(d), nrow = ntests, byrow = TRUE)

  data <- data.frame(
    name = c(rep("Modularity", ntests)),
    value = d1
  )


  data %>%
    ggplot(aes(x = name, y = value, fill = name)) +
    geom_boxplot() +
    scale_fill_viridis(discrete = TRUE, alpha = 0.6) +
    geom_jitter(color = "black", size = 1, alpha = 0.9) +
    theme_ipsum() +
    theme(
      legend.position = "none",
      plot.title = element_text(size = 11)
    ) +
    xlab("")
}