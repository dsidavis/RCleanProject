getDepends =
function(file, info = as(readScript(file), "ScriptInfo"))
{
  lapply(info, getDepend)
}

getDepend =
function(node)
{
   if("source" %in% node@functions)
      return(structure(c(source = node@strings), class = "SourceFileName"))
   if("load" %in% node@functions)
      return(structure(c(source = node@strings), class = "LoadFileName"))
   if("save" %in% node@functions)
      return(structure(c(source = node@strings), class = "SaveFileName")   )

   NULL
}

