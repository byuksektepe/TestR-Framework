# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #


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
  
  test.path <- paste0(getwd(), "/tests/")
  
  out <- tryCatch(
    
    expr = {
      
      test.files <- list.files(path=test.path, pattern=".yml", all.files=FALSE, full.names=FALSE)
      
      test.list <- lapply(test.files,
                          function(x) out <- yaml.load_file(paste0(test.path, x)))
      
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