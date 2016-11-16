# This code reads just the code that defines functions
# and then analyzes each of the resulting functions to see
# which functions it calls.  So we get the call graph between
# these functions.
# Then we compute which onese are not called by any of the other functions.
# These are candidates for "orphans"/unused functions.
# They are not necessarily unused, however. They  may be called directly
# within scripts. We can check the scripts using CodeDepends.
# Similarly, if this is code in a package, the uncalled
# functions may be the top-level user-callable functions.

library(codetools)

dir = "Variety_trial_analysis/code"
rfiles = list.files(dir, pattern = "\\.R$", full = TRUE)

isfunfile = grepl("funs\\.R$", rfiles)
rfunfiles = rfiles[isfunfile]

e = new.env()
invisible(sapply(rfunfiles, source, e))

funs = lapply(ls(e, all = TRUE), get, e)
names(funs) = ls(e, all = TRUE)
funs = funs[sapply(funs, is.function)]
g = lapply(funs, findGlobals, FALSE)

called = table(unlist(lapply(g, `[[`, "functions")))

setdiff(names(funs), names(called))
