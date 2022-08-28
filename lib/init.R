# ============================================================================ #
#
# TestR Framework                                                             
# 
# Licensed Under The MIT License
# 
# Copyright (c) 2022 Berkant Yüksektepe
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#   
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# 
# ============================================================================ #

# Init Required Packages
init.packages.list <- c("loadtest", "ggplot2", "ggpubr", "grid", "gridExtra", "png",
                        "jpeg", "stringr", "magrittr", "yaml","reshape2","data.tree", 
                        "purrr", "crayon", "roxygen2", "devtools")

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

# Load libraries
library(loadtest)
library(ggpubr)
library(ggplot2)
library(grid)
library(gridExtra)
library(png)
library(jpeg)
library(stringr)
library(magrittr)
library(crayon)

# Init Required Global Variables

logo      <- readPNG("img/TestR-Logo.png")
test_mark <- readPNG("img/TestR-Logo.png")
cover     <- readPNG("img/TestR-Cover-7619720.png")

# Read Const Variables

source(paste0(getwd(),"/lib/const.R"), chdir = FALSE)
