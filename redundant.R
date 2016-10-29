library(codetools)

rfiles = list.files("Variety_trial_analysis/code", pattern = "\\.R$", full = TRUE)

isfunfile = grepl("funs\\.R$", rfiles)
rfunfiles = rfiles[isfunfile]


e = new.env()
invisible(sapply(rfiles, source, e))

funs = lapply(ls(e, all = TRUE), get, e)
names(funs) = ls(e, all = TRUE)
funs = funs[sapply(funs, is.function)]
g = lapply(funs, findGlobals, FALSE)

called = table(unlist(lapply(g, `[[`, "functions")))

setdiff(names(funs), names(called))


scripts = rfiles[!isfunfile]

library(CodeDepends)
#sc = lapply(scripts, parse)
scripts = lapply(scripts, readScript)
info = lapply(scripts, as, "ScriptInfo")
names(sc) = scripts


tt = table(unlist(lapply(info, function(i) unlist(sapply(i, slot, "functions")))))
setdiff(names(funs), names(tt))

a = sc[[1]]

