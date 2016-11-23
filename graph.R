
# get all.dep from dependencies.R

# For each R script file  what it source()s, loads
# save later

library(igraph)

# Create all.dep from
# source("dependencies.R")

RCleanProject:::plot.Dependencies(all.dep)


g = makeGraph(all.dep, operations = c("source", "load", "save", "read_excel", "read_vt", "read.csv", "write.csv"))
RCleanProject::plot.Dependencies(, g)



