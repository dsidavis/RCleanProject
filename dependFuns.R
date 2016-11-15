getDepends =
function(file, info = as(readScript(file), "ScriptInfo"))
{
  tmp = lapply(info, getDepend)
  i = !sapply(tmp, is.null)
  if(!any(i))
      return(data.frame(filename = character(), operation = character(), expressionNum = integer()))
  
  ans = as.data.frame(do.call(rbind, tmp[i]), stringsAsFactors = FALSE)
  ans$expressionNum = which(i)
  ans
}

FileFunctionNames =
function(..., .funs = unlist(list(...)), .exclude = FALSE)
{
   if(.exclude)
      .funs
   else
      c("source", "load", "save", "png", "pdf", "read.csv", "read.table", "read.fwf", "file", "gzfile", "write.csv", .funs)
}

getDepend =
function(node, fileFunctionNames = FileFunctionNames())
{
   if(length(node@strings) && any(fileFunctionNames %in% names(node@functions))) {
          # what about sep = "\t"
      c(filename = node@strings, operation = names(node@functions))
   }
   else
     NULL
}

