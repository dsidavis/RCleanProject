# Assumes we have the names of the script files in scripts.
# See redundant.R
scripts = c("Variety_trial_analysis/code/calc_weather_var.R", "Variety_trial_analysis/code/cleaning.R", 
"Variety_trial_analysis/code/cv_in_field.R", "Variety_trial_analysis/code/getCIMIS.R", 
"Variety_trial_analysis/code/getPOWER.R", "Variety_trial_analysis/code/prep_stan_data.R", 
"Variety_trial_analysis/code/prep_temp_data.R", "Variety_trial_analysis/code/prep_temp.R", 
"Variety_trial_analysis/code/qc_weather.R", "Variety_trial_analysis/code/read_xl_data.R", 
"Variety_trial_analysis/code/recover_res.R", "Variety_trial_analysis/code/results.R", 
"Variety_trial_analysis/code/retreive_ucipm.R", "Variety_trial_analysis/code/sim_data.R", 
"Variety_trial_analysis/code/temp_analysis.R", "Variety_trial_analysis/code/temp_maps.R", 
"Variety_trial_analysis/code/test_thresh.R", "Variety_trial_analysis/code/vt_combine_data.R", 
"Variety_trial_analysis/code/vt_EDA.R")

library(CodeDepends)
#sc = lapply(scripts, parse)
sscripts = lapply(scripts, readScript)
info = lapply(sscripts, as, "ScriptInfo")
names(info) = scripts


all.dep = lapply(info, function(x) getDepends(, x))


x = table(unlist(lapply(info, function(x) lapply(x, function(x) names(x@functions)))))

getLibraries =
function(info)
{
    unlist(lapply(info, slot, "libraries"))
}
all.libs = table(unlist(lapply(info, getLibraries)))




tmp = lapply(info, function(x) getDepends(, x, FileFunctionNames("stan_rdump", "read_stan_csv", "read_vt", "read_vt_sheet")))
all.dep = do.call(rbind, tmp)
all.dep$SourceFilename = rep(names(info), sapply(tmp, nrow))
#rownames(all.dep) = seq(1, nrow(all.dep))


# Find orphans
