
mkTarget =
    #
    # tapply(all.dep, all.dep$SourceFilename, mkTarget)
    #
function(df, outputFuns = c("write.csv", "save", "png", "pdf"),prefix = "~/vt_project/")
{
   isTarget =  df$operation %in% outputFuns
   lapply(which(isTarget), function(i) genRule(df[i,], df[!isTarget,]))
}


genRule =
function(row, allRows)
{
   structure( list(target = row$filename,
                   dependencies = unique(c(allRows$filename, allRows$SourceFilename[1])),
                   sourceCode = allRows$SourceFilename[1]),
               class = "MakeTarget")
}


setOldClass("MakeTarget")
setAs("MakeTarget", "character",
        function(from) {
            cmd = sprintf("@(echo $^; Rscript '%s')", from$sourceCode)
            sprintf("%s: %s\n\t%s", from$target, paste(from$dependencies, collapse = " "), cmd)
        })
      
