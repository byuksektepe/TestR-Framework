init.packages.list <- c("loadtest", "ggplot2", "ggpubr")

for(package in init.packages.list)
  
  if (!requireNamespace(package, quietly = TRUE)) {
    print(paste0("Package", package, "is needed for TestR Framework.", package, "installing..."))
    
    if(package == "loadtest")
      remotes::install_github("tmobile/loadtest")
    else
      install.packages(package)
  }else {
    print(paste0(package, "is already installed"))
  }
