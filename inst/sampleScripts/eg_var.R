files = c("foo.csv", "bar.csv")
d = lapply(files, read.csv)


ans = list()
for(f in files)
  ans[[f]] = read.csv(f)


