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



