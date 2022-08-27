# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #

# Init Required Packages
init.packages.list <- c("loadtest", "ggplot2", "ggpubr", "grid", "gridExtra", "png",
                        "jpeg", "stringr", "magrittr", "yaml","reshape2","data.tree", "purrr", "crayon", "roxygen2")

current_date <- Sys.Date()
current_time <- Sys.time()

for(package in init.packages.list)
  
  if (!requireNamespace(package, quietly = TRUE)) {
    print(paste0("required package", package, " is needed for TestR Framework. ", package, " installing..."))
    
    if(package == "loadtest")
      remotes::install_github("tmobile/loadtest")
    
    else
      install.packages(package)
    
  }else {
    print(paste0("Required package: ",package, " is already installed."))
    
  }

# Init Required Global Variables

logo      <- readPNG("img/TestR-Logo.png")
test_mark <- readPNG("img/TestR-Logo.png")
cover     <- readPNG("img/TestR-Cover-7619720.png")

config.required.msg <- "TestR: Required config name of '%s' is not found in %s/config.yml file."
config.not.null.msg <- "TestR: '%s' is should be not null in %s/config.yml file."