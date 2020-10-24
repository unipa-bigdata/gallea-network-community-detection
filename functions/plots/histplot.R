histPlot <- function(result.vector) {

  modularity <- lapply(result.vector, "[", c("max.modularity"))
  modularity <- matrix(unlist(modularity))

  hist(modularity, labels = TRUE)
  axis(1, tck = 1, col.ticks = "light gray")
  axis(1, tck = -0.015, col.ticks = "black")
  axis(2, tck = 1, col.ticks = "light gray", lwd.ticks = "1")
  axis(2, tck = -0.015)
  minor.tick(nx = 5, ny = 2, tick.ratio = 0.5)
  box()
  hist(modularity, add = TRUE, labels = TRUE, col = "lightgray", xaxt = "n", yaxt = "n", xlab = "Wind Speed (m/s)", main = "Foo", cex.main = 1.5, cex.axis = 1, cex.lab = 1, font.lab = 2)
}