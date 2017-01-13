genMakefileCode =
    # m = genMakefileCode(all.deps)
    # cat( as(m, "character"), sep = "\n")
    # sapply(m, genMakeRule, function(b) 'echo "dummy rule"')
    # sapply(m, genMakeRule, function(b) sprintf('@echo "dummy rule for %s"', b$target))
    # sapply(m, genMakeRule, function(b) c('@echo "dummy rule"', "ls -1 *"))
    # cat(sapply(m, genMakeRule, function(b) c('@echo "dummy rule"', "ls -1 *")), sep = "\n\n")
function(deps, outputFuns = c("write.csv", "save", "png", "pdf"), prefix = "~/vt_project/")
{
    if(length(prefix) && !is.na(prefix)) {
       deps$filename = gsub(prefix, "", deps$filename)
       deps$SourceFilename = gsub(prefix, "", deps$SourceFilename)
    }
    
    ans = unlist(by(deps, deps$SourceFilename, mkTarget, outputFuns), recursive = FALSE)
    class(ans) = c("MakeTargets", class(ans))
    ans
}

mkTarget =
    #
    #
function(df, outputFuns = c("write.csv", "save", "png", "pdf"), prefix = "~/vt_project/")
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


genMakeRule <-
function(from, genMakeCommand = basicMakeCommand) {
    cmd = genMakeCommand(from)
    sprintf("%s: %s\n%s", from$target, paste(from$dependencies, collapse = " "), paste("\t", cmd, collapse = "\n"))
}

basicMakeCommand =
function(from)
{    
   sprintf("@(echo $^; Rscript '%s')", from$sourceCode)
}

setOldClass("MakeTarget")
setAs("MakeTarget", "character", function(from) genMakeRule(from))
      

setOldClass("MakeTargets")
setAs("MakeTargets", "character",
        function(from) {
           paste( sapply(from, as, "character"), collapse = "\n\n" )
        })
