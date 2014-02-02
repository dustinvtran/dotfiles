#
# R dotfile
# ~/.Rprofile
# Name: nil
#

# Default libraries.
#library(fields)
library(knitr)
library(rbenchmark)

# Hard code the US repo for CRAN.
r <- getOption("repos")
r["CRAN"] <- "http://cran.us.r-project.org"
options(repos = r)
rm(r)

# This is an aliased function that knits and compiles my problem sets, all in one step requiring just the problem set #.
knitme <- function(num) {
    # Knit using just the problem set #.
    if (num < 10) {
        num <- paste(0, num, sep = "")
    }
    filedir <- "/home/nil/Dropbox/nil/academics/berkeley-2014-spring/stat-135/problem-sets"
    filename <- paste(filedir, "/135-ps", num, ".Rtex", sep = "")
    filenameout <- paste(filedir, "/135-ps", num, ".tex", sep = "")
    knit(filename, output = filenameout)
    # Workaround for bug from knitr, requiring me to delete some redundant line output in my .tex.
    command <- paste("sed -i '12,60d' '", filenameout, "'", sep = "")
    system(command)
    # Compile and clean auxiliary files using rubber.
    command <- paste("rubber --into='", filedir, "' -d '", filenameout, "'", sep = "")
    system(command)
    command <- paste("rubber --into='", filedir, "' --clean '", filenameout, "'", sep = "")
    system(command)
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

# vim:filetype=conf
