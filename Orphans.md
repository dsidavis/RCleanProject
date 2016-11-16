There are different types of orphans.

+ CSV or RDA files that are never read by other files.
+ R files that are never source()'d
+ R functions that are never called.

redundant.R address the last of these.

getDepends() on each of the script files can identify the first two.

Given the data frame of which source files reference which input files,
we can get a list of all the potential input files. Then we can see which
are not in the list of referenced input files to find the orphans.
What we mean by input files depends on the type of file.
So we look in the dependency data frame returned by getDepends() for the operation value
being in the vectors  
```
   "source", 
   c("read.csv", "read.table", "read.fwf", "readLines", "file", "gzfile"), 
   "load"
```
For the output files, we look for operation in 
```
  c("pdf", "png", "jpeg")
  c("write.csv", "write.table"),
```

