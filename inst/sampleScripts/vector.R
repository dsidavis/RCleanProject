# Doesn't actually work, but mimics what other functions do w/o having to add them to the fileFunctionNames()

# Breaks the data frame concept. May want to put the filename into a list in this case.
x = read.csv(c("A.csv", "B.csv"))

# Not just c() but a call to a function. Ideally, we could figure out what the function would return.
# It could be dynamic (i.e. dependant on the actual value of the argument).
# But e.g., system.file() isn't.
y = read.csv(foo("XYZ.csv"))




