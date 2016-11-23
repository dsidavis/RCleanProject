source("dependencies.R")
source("R/genMake.R")

byfile = split(all.dep, all.dep$SourceFilename)

ans = lapply(byfile, mkTarget)

ans =do.call(c, ans)

ans = sapply(ans, as, "character")

writeLines(text = ans, con = "testmake", sep = "\n")
