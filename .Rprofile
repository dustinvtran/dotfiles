#
# R dotfile
# ~/.Rprofile
# Name: Dustin Tran
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
