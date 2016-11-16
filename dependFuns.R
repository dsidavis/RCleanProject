getDepends =
function(file, info = as(readScript(file), "ScriptInfo"), fileFunctionNames = FileFunctionNames())
{
  tmp = lapply(info, getDepend, fileFunctionNames = fileFunctionNames)

  i = !sapply(tmp, is.null)
  if(!any(i))
      return(data.frame(filename = character(), operation = character(), expressionNum = integer(), stringsAsFactors = FALSE))
  
  ans = as.data.frame(do.call(rbind, tmp[i]), stringsAsFactors = FALSE)
    # We are losing the expression number within the sub-expressions
  ans$expressionNum = rep(which(i), sapply(tmp[i], function(x) if(is.data.frame(x)) nrow(x) else 1))
  ans
}

#DefaultFileFunctions = c("source", "load", "save", "png", "pdf", "read.csv", "read.table", "read.fwf", "file", "gzfile", "write.csv")

#dput(structure(DefaultFileFunctions, names = unname(sapply(DefaultFileFunctions, function(x) names(formals(get(x, mode = "function")))[1]))))
DefaultFileFunctions =
 structure(c("source", "load", "save", "png", "pdf", "read.csv", 
"read.table", "read.fwf", "file", "gzfile", "write.csv"), .Names = c("file", 
"file", "...", "filename", "file", "file", "file", "file", "description", 
"description", "..."))
names(DefaultFileFunctions)[match(c("save","write.csv"), DefaultFileFunctions)] = "file"

FileFunctionNames =
function(..., .funs = unlist(list(...)), .exclude = FALSE)
{
   if(.exclude)
      .funs
   else
      c(DefaultFileFunctions, .funs)
}


getDependsLanguage =
function(code, fileFunctionNames = FileFunctionNames())
{
    i = new("ScriptInfo", lapply(code, getInputs))
    tmp = getDepends(, i, fileFunctionNames)         
    tmp
}

getDepend =
function(node, fileFunctionNames = FileFunctionNames(), funs = names(node@functions))
{

   if(length(node@strings) && any(fileFunctionNames %in% funs)) {
          # what about sep = "\t"

      funs = intersect(fileFunctionNames, names(node@functions))
      k = node@code
      if(class(k) == "if") {
         if(is.logical(k[[2]]) && !k[[2]]) {  #XXX Allow caller to specify this should be processed.
            if(length(k) == 4)
                return(getDependsLanguage(k[[4]], fileFunctionNames))
                       
            return(NULL)
         }

         return(getDependsLanguage(k[[3]], fileFunctionNames))
      }
          
      if(class(k) %in% c("<-", "="))
          k = k[[3]]

      if(is.call(k) && !(as.character(k[[1]]) %in% funs)) {
          # Have to find which elements of the call contain the actual function of interest
#        tmp = lapply(k[-1], function(x) getDepend(getInputs(x), fileFunctionNames, funs = funs))
#         i = getInputs(k[-1])
#         if(length(k) == 2)
#            i = new("ScriptInfo", list(i))
         i = new("ScriptInfo", lapply(seq(along = k[-1]), function(i) getInputs(k[[i+1]])))
         tmp = getDepends(, i, fileFunctionNames)
         return(tmp)
# for simple nested calls, e.g. scale(read.csv("foo.csv")), use
#        k = k[[2]]
      }
      
      funName = as.character(k[[1]])
 if(funName == "if") browser()
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

