SA <- function(network, T, sol, nsim = 1000, pchange = 0.1, metric, callback = NULL) {
  vertices = sort(unique(unlist(network)))
  n = length(vertices)

  T0 <- T$T0
  Tf <- T$Tf

  A = T0
  B = log(Tf / A) / nsim
  Temp = A * exp(B * (1:nsim))

  modularityPROC = c()
  modularityPROCBest = c()

  bestSol <- solNew <- sol

  modularityBEST = metric(network, solNew, vertices)


  for (t in 1:nsim) {
    if (!is.null(callback)) {
      callback(t)
    }

    nodes_to_change <- min(rpois(1, round(n * pchange)), n)
    nodeRAN = sample(1:n, nodes_to_change)
    solNew[nodeRAN] = ifelse(solNew[nodeRAN] == 1, 2, 1)

    modularityNEW = metric(network, solNew, vertices)

    diff = modularityBEST - modularityNEW

    if (max(modularityPROCBest[t - 1], -1000) > modularityNEW) {
      modularityPROCBest[t] = modularityPROCBest[t - 1]
    } else {
      bestSol = sol
      modularityPROCBest[t] <- modularityNEW
    }

    if (diff < 0) {
      modularityBEST = modularityNEW
      sol = solNew
    } else {
      p = exp(-diff / Temp[t])
      if (runif(1) <= p) {
        modularityBEST = modularityNEW
        sol = solNew
      }
    }

    modularityPROC[t] = modularityBEST
  }

  network.final <- network
  network.final$communityA <- integer(nrow(network))
  network.final$communityB <- integer(nrow(network))

  for (i in 1:length(network.final$V1)) {
    network.final$communityA[i] = bestSol[network.final$V1[i]]
    network.final$communityB[i] = bestSol[network.final$V2[i]]
  }

  returnValue(list('network.final' = network.final, 'solution' = bestSol, 'modularity' = modularityPROC, 'best.modularity' = modularityPROCBest, 'max.modularity' = max(modularityPROCBest)))
}