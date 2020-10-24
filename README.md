# Network community detection

This project contains the code for the assignment for the first part of Machine Learning module of the Data Science 
and Big Data Analysis Master.

It is an R project aimed to Network Community Detection by means of network modularity maximization.

## Project Report

The report for the project is available at https://github.com/unipa-bigdata/gallea-network-community-detection/blob/master/Machine_Learning_Network_Project.pdf

## Running the code

For demonstration purposes, three main R files exist, all processing the network `web-edu.mtx`:

- `singleOptimization.R` - Runs single execution of Simulated Annealing optimization

- `multiOptimization.R` - Runs 1000 executions of Simulated Annealing optimization and extracts statistics from the 
results

- `gaOptimization.R` - Runs single execution of Genetic Algorithm optimization (tooks a lot of time to complete)
