

# get all.dep from dependencies.R

# For each R script file  what it source()s, loads
# save later

grps = split(all.dep, all.dep$SourceFilename)
tmp = lapply(grps, function(d) {
                tt = unique(basename(d[d$operation %in% c("source", "load"), "filename"]))
                cbind(rep(basename(d$SourceFilename[1]), length(tt)), tt)
             })
m = do.call(rbind, tmp)

library(igraph)
g = graph.edgelist(m)

plot(g, vertex.size = 10, vertex.label.cex = 3, edge.color = "blue") # , edge.arrow.width = 0)

V(g)$color[ grepl("Rda", V(g)$name)] =  "lightgray"
plot(g, vertex.size = 10, vertex.label.cex = 3, edge.color = "black") # , edge.arrow.width = 0)


############

grps = split(all.dep, all.dep$SourceFilename)
tmp = lapply(grps, function(d) {
                tt = unique(basename(d[d$operation %in% c("source", "load", "save", "read_excel", "read_vt", "read.csv", "write.csv"), "filename"]))
                cbind(rep(basename(d$SourceFilename[1]), length(tt)), tt)
             })
m = do.call(rbind, tmp)

library(igraph)
g = graph.edgelist(m)

plot(g, vertex.size = 10, vertex.label.cex = 3, edge.color = "blue") # , edge.arrow.width = 0)

V(g)$color[ grepl("Rda$", V(g)$name)] =  "lightgray"
V(g)$color[ grepl("csv$", V(g)$name)] =  "pink"
V(g)$color[ grepl("xlsx?$", V(g)$name)] =  "yellow"
plot(g, vertex.size = 10, vertex.label.cex = 3, edge.color = "black") # , edge.arrow.width = 0)
