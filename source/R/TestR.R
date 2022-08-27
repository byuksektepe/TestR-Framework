# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #

# Check libraries installed or install
source(paste0(getwd(),"/source/lib/init.R"), chdir = TRUE)
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
library(crayon)



test_url <- c("https://www.github.com")
test_url_formatted <- str_replace(test_url, "https://","")



thr = 7
loops = 40

automation_tag <- paste0(test_url_formatted," (THR: ",thr,", LPS: ",loops,")")


do.load.test <- function(url, 
                         method, 
                         thread, 
                         loop, 
                         delay){
  
  return(loadtest(url = url, 
                  method = method, 
                  threads = thread, 
                  loops = loop, 
                  delay_per_request = delay))
}

TestR <- function(){
  
  run <- lapply(tdata, function(x) 
    
    for(r in x){
      
      # --> Raw
      nam <- r[[1]]$name
      des <- r[[1]]$description
      url <- r[[1]]$url
      met <- r[[1]]$method
      thr <- r[[1]]$thread
      lop <- r[[1]]$loop
      del <- r[[1]]$delay
      # <--
      
      # --> Formatted
      url.f <- url %>% str_replace("https://","")
      test.t <- sprintf("%s (THR: %s, LPS: %s)", nam, thr, lop)
      # <--
      
      sprintf("-> TestR: Start by Test Name: %s \n", nam) %>%
        cyan() %>%
          cat()
      
      res <- do.load.test(url, 
                          met, 
                          thr, 
                          lop, 
                          del)
      
      sprintf("-> TestR: End by Test Name: %s \n - \n", nam) %>%
        cyan() %>%
        cat()
      
      sprintf("-> TestR: Start to PDF Export by Test Name: %s \n - \n", nam) %>%
        yellow() %>%
        cat()
      
      CreatePDF.TestR(results = res, automation_tag = test.t)
      
      sprintf("-> TestR: End PDF Export by Test Name: %s \n - \n", nam) %>%
        yellow() %>%
        cat()
  })
}

TestR()



