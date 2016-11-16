getDepends =
function(file, info = as(readScript(file), "ScriptInfo"), fileFunctionNames = FileFunctionNames())
{
  tmp = lapply(info, getDepend, fileFunctionNames = fileFunctionNames)

  i = !sapply(tmp, is.null)
  if(!any(i))
      return(data.frame(filename = character(), operation = character(), expressionNum = integer()))
  
  ans = as.data.frame(do.call(rbind, tmp[i]), stringsAsFactors = FALSE)
  ans$expressionNum = which(i)
  ans
}

#DefaultFileFunctions = c("source", "load", "save", "png", "pdf", "read.csv", "read.table", "read.fwf", "file", "gzfile", "write.csv")

#dput(structure(DefaultFileFunctions, names = unname(sapply(DefaultFileFunctions, function(x) names(formals(get(x, mode = "function")))[1]))))
DefaultFileFunctions =
 structure(c("source", "load", "save", "png", "pdf", "read.csv", 
"read.table", "read.fwf", "file", "gzfile", "write.csv"), .Names = c("file", 
"file", "...", "filename", "file", "file", "file", "file", "description", 
"description", "..."))


FileFunctionNames =
function(..., .funs = unlist(list(...)), .exclude = FALSE)
{
   if(.exclude)
      .funs
   else
      c(DefaultFileFunctions, .funs)
}

getDepend =
function(node, fileFunctionNames = FileFunctionNames())
{

   if(length(node@strings) && any(fileFunctionNames %in% names(node@functions))) {
          # what about sep = "\t"

      k = node@code
      funs = names(node@functions)
      if(class(k) %in% c("<-", "="))
          k = k[[3]]

      funName = as.character(k[[1]])
      fun = tryCatch(get(funName, mode = "function"), error = function(...) NULL)
      if(!is.null(fun) && typeof(fun) == "closure") {  # avoud "function" objects which are primitives.
          kall =  match.call(fun, k)
          i = match(funName, fileFunctionNames)
          arg = names(fileFunctionNames)[i]
          if(arg == "")
              arg = 1
          file = kall[[arg]]
      } else {
          file = k[[2]]
      }

      
      c(filename = file, operation = funName)
   }
   else
     NULL
}

