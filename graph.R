

# get all.dep from dependencies.R

# For each R script file  what it source()s, loads
# save later

library(igraph)


plot.Dependencies(all.dep)


g = makeGraph(all.dep, operations = c("source", "load", "save", "read_excel", "read_vt", "read.csv", "write.csv"))
plot.Dependencies(, g)


