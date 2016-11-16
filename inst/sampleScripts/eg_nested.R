x = scale(read.csv("foo.csv"))


# Contrived example for now.
x = mapply(function(x) class(x), read.csv("bar.csv"))

