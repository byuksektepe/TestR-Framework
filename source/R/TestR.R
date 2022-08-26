# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #

# Check libraries installed or install
source(paste0(getwd(),"/source/lib/init.R"), chdir = TRUE)
# Load Plots
source(paste0(getwd(),"/source/plots/load.test.plots.R"), chdir = TRUE)
# Get Data Functions
source(paste0(getwd(),"/source/R/get.data.R"), chdir = FALSE)
# Export Data Functions
source(paste0(getwd(),"/source/R/export.data.R"), chdir = FALSE)

# Set Jmeter Environment Variable
jver <- get.jmeter.version()

# Get test data from yaml files
tdata <- get.test.data()

Sys.setenv("LOADTEST_JMETER_PATH"=sprintf("C:\\apache-jmeter-%s\\bin\\jmeter.bat", jver))

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



test_url <- c("https://www.github.com")
test_url_formatted <- str_replace(test_url, "https://","")

logo <- readPNG("img/TestR-Logo.png")
test_mark <- readPNG("img/TestR-Logo.png")

cover <- readPNG("img/TestR-Cover-7619720.png")

thr = 7
loops = 40

automation_tag <- paste0(test_url_formatted," (THR: ",thr,", LPS: ",loops,")")
automation_tag_formatted <- str_remove_all(automation_tag, "[^A-Za-z0-9]+")

do.load.test <- function(url, method, thread, loop, delay){
  return(loadtest(url = url, method = method, threads = thread, loops = loop, delay_per_request = delay))
}

TestR <- function(){
  
  out <- lapply(tdata, function(x) for(r in x){
    
    results <- do.load.test(r[[1]]$url, r[[1]]$method, r[[1]]$thread, r[[1]]$loop, r[[1]]$delay)
  })
}

TestR()



