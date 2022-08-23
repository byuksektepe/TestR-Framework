init.packages.list <- c("loadtest", "ggplot2", "ggpubr", "grid", "gridExtra", "png", "jpeg", "stringr")
current_date <- Sys.Date()
current_time <- Sys.time()

for(package in init.packages.list)
  
  if (!requireNamespace(package, quietly = TRUE)) {
    print(paste0("required package", package, "is needed for TestR Framework.", package, "installing..."))
    
    if(package == "loadtest")
      remotes::install_github("tmobile/loadtest")
    
    else
      install.packages(package)
    
  }else {
    print(paste0(package, " is already installed"))
    
  }
