main <- function() {
  
  # my.packages should be a character vector of package names to load
  load.packages <- function(my.packages) {
    
    #local function to check if a library is installed, if not, install, if so, load
    load.package <- function(pack.name) {
      # pack_name is the name of a package to install
      if(!(pack.name %in% installed.packages())) {
        cat("installing", pack.name)
        install.packages(pack.name, lib = "/usr/lib/R/site-library")
      }
      # require will return true if the library is loaded
      return(require(pack.name, character.only=TRUE))
    }
    
    cat("loading", my.packages, sep = "\n")
    sapply(my.packages, load.package)  
  }
  
  # args should be a sequence of package names to load
  args <- commandArgs(trailingOnly = TRUE)
  cat("args=", args, sep = "\n")
  load.packages(args)
}

main()

