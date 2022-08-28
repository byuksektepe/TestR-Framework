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


library(yaml)
library(reshape2)
library(purrr)
library(magrittr)


#' Read Test Data
#' reads all test files from defined folder
#'
#' @return : List : Test.List
#' @export
#'
#' @examples
read.test.data <- function(){
  
  test.path <- list.dirs(paste0(getwd(), "/tests"))
  
  out <- tryCatch(
    
    expr = {
      
      test.files <- list.files(path=test.path, pattern="\\.yml$", all.files=FALSE, full.names=TRUE)
      
      test.list <- lapply(test.files,
                          function(x) out <- yaml.load_file(x))
       
    },
    
    error = function(e){
      
      test.not.read <- sprintf("TestR: Error in Read Test Files: %s", e)
      
      test.not.read %>% stop()
      
    },
    
    finally = function(){
      
      return(test.list)
      
    }
  )
  return(out)
}


#' Read Config Data
#' reads config file from defined folder
#'
#' @return : List : Config.Data
#' @export
#'
#' @examples
read.config.data <- function(){
  
  config.path <- paste0(getwd(), "/config.yml")
  
  out <- tryCatch(
    
    expr = {
      
      config.data <- yaml.load_file(config.path)
      
    },
    
    error = function(e){
      
      config.not.read <- sprintf("TestR: Error in Read Config File: %s, config.yml file must be in base project directory.", e)
      
      config.not.read %>% stop()
      
    },
    
    finally = function(){
      
      config.data %>% {
        
        if(!is.null(.)) return(.)
        
        else{
          
          config.data.is.null <- sprintf("TestR: Receiven config data is NULL, please check %s/config.yml file.", getwd())
          
          config.data.is.null %>% stop()
          
        }
      }
    }
  )
  return(out)
}


var_test <- read.test.data()
var_config <- read.config.data()