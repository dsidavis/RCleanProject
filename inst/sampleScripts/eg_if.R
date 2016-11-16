if(FALSE) {
  d = read.csv("foo.csv")
}


if(TRUE)  {
  d = read.csv("foo2.csv")
}

sym = TRUE

if(sym)  {
  d = read.csv("bar.csv")
}


if(FALSE) {
  d = read.csv("outofthequestion.csv")
} else
  d = read.csv("other.csv")


if(FALSE) {
  d = read.csv("noway.csv")
} else {
  d = read.csv("other.csv")
}

if(FALSE) {
  d = read.csv("no.csv")
} else {
  d = read.csv("A.csv")
  e = read.csv("B.csv")  
}
