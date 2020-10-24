estimateTemperatures <- function(network) {
  vertices = sort(unique(unlist(network)))
  n = length(vertices)

  modularityVEC = c()
  nsim = 200
  for (i in 1:nsim) {
    sol = sample(c(1, 2), n, replace = T)
    modularityVEC[i] = modularity(network, sol, vertices = vertices)
  }

  dis = c()
  for (i in 1:(nsim - 1)) {
    for (j in (i + 1):nsim) {
      disttemp = abs(modularityVEC[i] - modularityVEC[j])
      dis = append(dis, disttemp)
    }
  }

  mm = mean(dis)

  T0 = 100 * mm
  Tf = mm / 100

  returnValue(list('T0' = T0, 'Tf' = Tf))
}