
# This code attempts to find the functions that are defined but not
# called by any script and not called by any other function defined in this project.
# It can still miss some unused functions for now, e.g.,
#  a function that is called by another function but that other function is never called.
# We can determine this, just haven't done so yet.

source("redundantFunctions.R")

# Just look at the script files.
scripts = rfiles[!isfunfile]


# Use CodeDepends to get information about the inputs and outputs and dependencies
# of each expression in each script.
library(CodeDepends)
sscripts = lapply(scripts, readScript)
info = lapply(sscripts, as, "ScriptInfo")
names(info) = scripts

# Now get the functions called in each expression across all scripts
tt = table(unlist(lapply(info, function(i) unlist(sapply(i, function(x) names(x@functions))))))

# We have already computed the names of the functions that were defined in the project
# files but not called by any other function. These are in notCalled.
# So we can see which ones are not referenced in the scripts either.
setdiff(notCalled, names(tt))

# [1] "calc_vars"     "check_missing" "compare_stn"   "cv_weather"    "fill_missing"  "get_stn_info"  "get_ucipm"     "over35"       
# [9] "under15"       "wrangle_vt"   

#  under15 and over35, get_stn_info, get_ucipm, fill_missing, compare_stn, are defined and not called by any R code in code/
# So these are legitimately orphaned/unused.
#
# This doesn't quite work as we (including codetools) don't handle functions
# used in lapply/sapply/mapply/mclapply
# calc_vars, check_missing, wrangle_vt cv_weather are examples of this.
# However, we can catch them via the @inputs slot for the ScriptNodeInfo
#
tt = table(unlist(lapply(info, function(i) unlist(sapply(i, function(x) c(names(x@functions), x@inputs))))))
setdiff(notCalled, names(tt))
# [1] "compare_stn"  "fill_missing" "get_stn_info" "get_ucipm"    "over35"       "under15"      "wrangle_vt"  


a = sc[[1]]

