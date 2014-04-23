#
# R dotfile
# ~/.Rprofile
# Name: nil
#

# Default libraries.
#library(fields)
#library(MASS)
library(knitr)
library(rbenchmark)

# Hard code the US repo for CRAN.
r <- getOption("repos")
r["CRAN"] <- "http://cran.us.r-project.org"
options(repos = r)
rm(r)

# knitme knits/compiles my .Rtex problem sets while requiring only the problem set # as input. It assumes: 1. you are in the working directory, and 2. follow the correct filename format.
knitme <- function(psnum) {
    # Knit using just the problem set #.
    if (psnum < 10) {
        psnum <- paste(0, psnum, sep = "")
    }
    string <- paste("-ps", psnum, ".Rtex", sep="")
    filename <- list.files()[grep(string,list.files())]
    filenameout <- gsub(".Rtex", ".tex", filename)
    knit(filename, output = filenameout)
    # Workaround for bug from knitr, requiring me to delete some redundant line output in my .tex.
    command <- paste("sed -i '12,60d' '", filenameout, "'", sep = "")
    system(command)
    # Compile and clean auxiliary files using rubber.
    command <- paste("rubber -d '", filenameout, "'", sep = "")
    system(command)
    command <- paste("rubber --clean '", filenameout, "'", sep = "")
    system(command)
}

# panel.cor puts correlation in upper panels of pairs plots, the size proportional to correlation
panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
    usr <- par("usr"); on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- abs(cor(x, y))
    txt <- format(c(r, 0.123456789), digits=digits)[1]
    txt <- paste(prefix, txt, sep="")
    if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
    text(0.5, 0.5, txt, cex = cex.cor * r)
}

# List the top ranked objects with the largest size.
ls.sizes <- function(howMany = 10, minSize = 1){
        pf <- parent.frame()
        obj <- ls(pf) # or ls(sys.frame(-1))
        objSizes <- sapply(obj, function(x) {
        object.size(get(x, pf))})
        # or sys.frame(-4) to get out of FUN, lapply(), sapply() and sizes()
        objNames <- names(objSizes)
        howmany <- min(howMany, length(objSizes))
        ord <- order(objSizes, decreasing = TRUE)
        objSizes <- objSizes[ord][1:howMany]
        objSizes <- objSizes[objSizes > minSize]
        objSizes <- matrix(objSizes, ncol = 1)
        rownames(objSizes) <- objNames[ord][1:length(objSizes)]
        colnames(objSizes) <- "bytes"
        cat('object')
        print(format(objSizes, justify = "right", width = 11), quote = FALSE)
}

# This sources all files in a given directory, defaulted to the working directory.
sourceDir <- function(path=getwd(), trace = TRUE, ...) {
    for (nm in list.files(path, pattern = "\\.[RrSsQq]$")) {
       if(trace) cat(nm,":")
       source(file.path(path, nm), ...)
       if(trace) cat("\n")
    }
}

# vim:filetype=conf
