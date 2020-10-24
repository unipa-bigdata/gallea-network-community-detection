source('functions/functions.R')
source('functions/SA.R')
source('functions/estimateTemperatures.R')

filename <- 'web-edu_adj.mtx'
network = read.table(filename)

nsim = 1000

pb <- txtProgressBar(min = 0, max = nsim, style = 3)

progressCallback <- function(step) {
  setTxtProgressBar(pb, step)
}

result <- SA(
  network = network,
  T = estimateTemperatures(network = network),
  sol <- getStartingPoint(network),
  nsim = nsim,
  metric = modularity,
  callback = progressCallback
)

plot(result$modularity, type = 'l')
plot(result$best.modularity, type = 'l')


write.table(
  result$network.final,
  paste(filename, '.SA.txt'),
  col.names = TRUE, row.names = FALSE
)

