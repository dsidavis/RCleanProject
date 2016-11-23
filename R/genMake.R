
mkTarget = 
function(df, outputFuns = c("write.csv", "save", "png", "pdf"),prefix = "~/vt_project/")
{
   isTarget =  df$operation %in% outputFuns
   lapply(which(isTarget), function(i) genRule(df[i,], df[!isTarget,]))
}


genRule =
function(row, allRows)
{
    list(target = row$filename, dependencies = unique(c(allRows$filename, allRows$SourceFilename[1])),
          sourceCode = allRows$SourceFilename[1])
}
