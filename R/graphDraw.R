plot.Dependencies = 
function(deps, g = makeGraph(deps, operations), operations = c("source", "load", "save"),
           fileTypeColors = c("Rda" = "lightgray", cvs = "pink", "xlsx?$" = "yellow"), ...)
{
    for(i in names(fileTypeColors))
        V(g)$color[ grepl(names(fileTypeColors[i]), V(g)$name)] =  fileTypeColors[i]

    plot(g, vertex.size = 10, vertex.label.cex = 3, edge.color = "black", ...) # , edge.arrow.width = 0)
}

makeGraph =
function(deps, operations = c("source", "load", "save", "read_excel", "read_vt", "read.csv", "write.csv"))
{
    grps = split(deps, deps$SourceFilename)
    tmp = lapply(grps, function(d) {
                tt = unique(basename(d[d$operation %in% operations, "filename"]))
                cbind(rep(basename(d$SourceFilename[1]), length(tt)), tt)
             })
    m = do.call(rbind, tmp)

    library(igraph)
    graph.edgelist(m)
}
