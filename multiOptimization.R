source('functions/functions.R')
source('functions/SA.R')
source('functions/estimateTemperatures.R')
source('functions/plots/confidence.R')
source('functions/plots/boxplot.R')
source('functions/plots/histplot.R')

filename <- '/home/roberto/Scrivania/Master/MachineLearning/Networks/web-edu_adj.mtx'
network = read.table(filename)


ntests <- 1000
nsim <- 1000

result.vector <- array(list(), ntests)

pb <- txtProgressBar(min = 0, max = ntests*nsim, style = 3)

progressCallback <- function(step) {
  setTxtProgressBar(pb, (i - 1) * nsim + step)
}

temperatures = estimateTemperatures(network)

for (i in 1:ntests) {
  result <- SA(
    network = network,
    T = temperatures,
    sol = getStartingPoint(network),
    nsim = nsim,
    metric = modularity,
    callback = progressCallback
  )

  result.vector[[i]] <- result
}

confidencePlot(result.vector, "best.modularity", nsim)
confidencePlot(result.vector, "modularity", nsim)
boxPlot(result.vector, ntests)
histPlot(result.vector)

#save.image('multiOptimization.Rdata')
