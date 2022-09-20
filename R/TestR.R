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

# Check libraries installed or install
source(paste0(getwd(),"/lib/init.R"), chdir = TRUE)
# Load Helper Functions
source(paste0(getwd(),"/R/helper.R"), chdir = FALSE)
# Get Data Functions
source(paste0(getwd(),"/R/get.data.R"), chdir = FALSE)
# Export Data Functions
source(paste0(getwd(),"/R/export.data.R"), chdir = FALSE)
# Read Consts 
source(paste0(getwd(),"/lib/const.R"), chdir = TRUE)

# Set Jmeter Environment Variable
jver <- get.jmeter.version()


switch(Sys.info()[['sysname']],
       Windows= {Sys.setenv("LOADTEST_JMETER_PATH"=sprintf("C:\\apache-jmeter-%s\\bin\\jmeter.bat", jver))},
       Linux  = {Sys.setenv("LOADTEST_JMETER_PATH"=sprintf("linux path test", jver))},
       Darwin = {Sys.setenv("LOADTEST_JMETER_PATH"=sprintf("mac os path", jver))})

# Get test data from yaml files
tdata <- get.test.data()


#' T-Mobile Load Test Library Function
#'
#' @param url : String
#' @param method : String
#' @param thread : String
#' @param loop : String
#' @param delay : String
#'
#' @return : Data Frame:  LoadTest Results
#' @export
#'
#' @examples
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


#' TestR Framework Main Function
#'
#' @return
#' @export PDF
#'
#' @examples
TestR <- function(){
  
  #Set Global Configs in Test Runtime
  TestR.export.pdf <- get.global.config(x="export-pdf")
  TestR.export.html <- get.global.config(x="export-html")
  
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
      exe <- r[[1]]$execute
      # <--
      
      # --> Formatted
      url.f <- url %>% str_remove(remove.str.https)
      
      test.t <- sprintf(test.tag.title, nam, thr, lop)
      
      test.n <- Create.Test.Index()
      # <--
      
      # --> Test Execution
      
      if(isTRUE(exe)){
        
        sprintf(test.start.msg, nam) %>%
          cyan() %>%
          cat()
        
        res <- do.load.test(url, 
                            met, 
                            thr, 
                            lop, 
                            del)
        
        sprintf(test.end.msg, nam) %>%
          cyan() %>%
          cat()
        
        
        if(isTRUE(TestR.export.pdf)){
          
          Create.Console.Message.sprintf(
            msg = export.pdf.start.msg, 
            name = nam)
          
          CreatePDF.TestR(results = res,
                          automation_tag = test.t,
                          description = des,
                          url = url.f,
                          index = test.n)
          
          Create.Console.Message.sprintf(
            msg = export.pdf.end.msg,
            name = nam)
          
        }else {
          Create.Console.Message.sprintf(
            msg = export.pdf.skip.msg,
            name = nam)
        }
      }else if(isFALSE(exe)){
        Create.Console.Message.sprintf(
          msg = test.skip.msg,
          name = nam)
      }else {
        Create.Console.Message.sprintf(
          msg = test.exe.fail,
          name = nam)
      }
      
      # <---
      
  })
}

TestR()