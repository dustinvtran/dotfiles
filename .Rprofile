#
# R dotfile
# ~/.Rprofile
# Name: nil
#

# Default libraries.
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
    filedir <- "/home/nil/Dropbox/nil/Academics/Berkeley 2013 ZFall/Stat 243/Problem Sets"
    filename <- paste(filedir, "/243-ps", num, ".Rtex", sep = "")
    filenameout <- paste(filedir, "/243-ps", num, ".tex", sep = "")
    knit(filename, output = filenameout)
    # Workaround for bug from knitr, requiring me to delete some redundant line output in my .tex.
    command <- paste("sed -i '11,59d' '", filenameout, "'", sep = "")
    system(command)
    # Compile and clean auxiliary files using rubber.
    command <- paste("rubber --into='", filedir, "' -d '", filenameout, "'", sep = "")
    system(command)
    command <- paste("rubber --into='", filedir, "' --clean '", filenameout, "'", sep = "")
    system(command)
}
# vim:filetype=conf
