modularity = function(network = network, solution = solution, vertices = vertices) {
  n = length(vertices)
  L = dim(network)[1]
  Ki = as.vector(unname(table(unlist(network))))

  linksCOM = network
  linksCOM = cbind(solution[linksCOM[, 1]], solution[linksCOM[, 2]])

  e = c()
  for (i in 1:2) {
    subl = subset(linksCOM, linksCOM[, 1] == i & linksCOM[, 2] == i)
    e[i] = nrow(subl)
  }
  er = e / L
  matrCOMM = cbind(solution, Ki)

  a = c()
  for (i in 1:2) {
    subl = subset(matrCOMM, matrCOMM[, 1] == i)
    a[i] = sum(subl[, 2])
  }
  ar = a / (2 * L)
  ar2 = ar^2
  modularityAA = sum(er - ar2)
  return(modularityAA)
}


getStartingPoint <- function(network) {
  vertices = sort(unique(unlist(network)))
  n = length(vertices)
  returnValue(sample(c(1, 2), n, replace = T))
}

getStartingPoint2 <- function(network) {
  vertices = sort(unique(unlist(network)))
  n = length(vertices)
  L = dim(network)[1]
  Ki = as.vector(unname(table(unlist(network))))
  startingPoint <- integer(n)
  startingPoint[Ki >= median(Ki)] <- 1
  startingPoint[Ki < median(Ki)] <- 2
  returnValue(startingPoint)
}

getStartingPoint3 <- function(network) {
  vertices = sort(unique(unlist(network)))
  n = length(vertices)
  returnValue(integer(n) + 1)
}