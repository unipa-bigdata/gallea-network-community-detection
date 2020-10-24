library(GA)
library(parallel)
library(doParallel)

source('functions/functions.R')

filename <- 'web-edu_adj.mtx'
network = read.table(filename)

vertices = sort(unique(unlist(network)))

fitness <- function(x)  modularity(network, x + 1, vertices)

GA <- gaisl(
  type = "binary",
  fitness = fitness,
  popSize = 100,
  maxiter = 20000, run = 100,
  numIslands = 4,
  migrationRate = 0.2,
  migrationInterval = 50,
  pmutation = 0.1,
  nBits = length(vertices)
)
plot(GA)

network.final <- network
network.final$communityA <- integer(nrow(network))
network.final$communityB <- integer(nrow(network))
for (i in 1:length(network.final$V1)) {
  network.final$communityA[i] = GA@solution[network.final$V1[i]] + 1
  network.final$communityB[i] = GA@solution[network.final$V2[i]] + 1
}

write.table(
  network.final,
  paste(filename, '.GA.txt'),
  col.names = TRUE,
  row.names = FALSE
)

#save.image('GA.Rdata')