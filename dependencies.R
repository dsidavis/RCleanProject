library(RCleanProject)

# Assumes we have the names of the script files in scripts.
# See redundant.R
scripts = c("~/vt_project/code/calc_weather_var.R", "~/vt_project/code/cleaning.R", 
"~/vt_project/code/cv_in_field.R", "~/vt_project/code/getCIMIS.R", 
"~/vt_project/code/getPOWER.R", "~/vt_project/code/prep_stan_data.R", 
"~/vt_project/code/prep_temp_data.R", "~/vt_project/code/prep_temp.R", 
"~/vt_project/code/qc_weather.R", "~/vt_project/code/read_xl_data.R", 
"~/vt_project/code/recover_res.R", "~/vt_project/code/results.R", 
"~/vt_project/code/retreive_ucipm.R", "~/vt_project/code/sim_data.R", 
"~/vt_project/code/temp_analysis.R", "~/vt_project/code/temp_maps.R", 
"~/vt_project/code/test_thresh.R", "~/vt_project/code/vt_combine_data.R", 
"~/vt_project/code/vt_EDA.R")

library(CodeDepends)
#sc = lapply(scripts, parse)
sscripts = lapply(scripts, readScript)
info = lapply(sscripts, as, "ScriptInfo")
names(info) = scripts


# This isn't the one we actually want. We use this to see the names of the
# functions that are called that might be reading or writing data, or creating plots.
all.dep = lapply(info, function(x) getDepends(, x))

x = table(unlist(lapply(info, function(x) lapply(x, function(x) names(x@functions)))))


# Now we know we need to include the following functions for this particular project.
tmp = lapply(info, function(x) getDepends(, x, FileFunctionNames("stan_rdump", "read_stan_csv", "read_vt", "read_vt_sheet")))
all.dep = do.call(rbind, tmp)
all.dep$SourceFilename = rep(names(info), sapply(tmp, nrow))
rownames(all.dep) = NULL # seq(1, nrow(all.dep))

# There are names on the operation vector that don't help.
#all.dep$operation = unname(all.dep$operation)


# Find orphans
# When all.dep$operation is a simple character vector, we can look for the elements in all.dep that contain values  in
# read_stan_csv, read_vt, read_vt_sheet, read.csv, read.table,  etc.
# Then we look at the corresponding filename values and compare these to
# list.files(dataDirectory)
# and then use setdiff()  with basename() as needed.

# The RDA files.
 # Which are explicitly loaded, written by R via our code, and which exist.
loaded = basename(all.dep[all.dep$operation == "load", "filename"])
written = basename(all.dep[all.dep$operation == "save", "filename"])
exist.rda = list.files("~/vt_project/data", pattern = "\\.[Rr]da$")
 # The ones that aren't written and alrea

intersect(written, loaded)
setdiff(exist.rda, c(written, loaded))


exist.Rfiles = list.files("~/vt_project/code", pattern = "\\.[Rr]$")
sourced = basename(all.dep[all.dep$operation == "source", "filename"])
setdiff(exist.Rfiles, sourced)




