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

source(paste0(getwd(), "/R/read.data.R"))

library(purrr)
library(magrittr)


#' Get JMeter Version
#' gets jmeter version from pre-defined config names in config.yml file
#'
#' @return : String : Jmeter.Version.Value
#' @export
#'
#' @examples
get.jmeter.version <- function(){
  
  jmeter.name <- "Jmeter-version"
  
  out <- tryCatch(
    
    expr = {
      
      jmeter.data <- var_config %>%
        
        flatten %>%
        
        keep(~ .x$name == jmeter.name)
      
      jmeter.version <- jmeter.data[[1]]$value
      
    },
    
    error = function(e){
      
      jmeter.not.found <- sprintf(config.required.msg, 
                              jmeter.name, 
                              getwd())
      jmeter.not.found %>%
        stop()
    },
    
    finally = function(){
      
      jmeter.version %>% {
        
        if(!is.null(.)) return(.) 
        
        else {
          jmeter.is.null <- sprintf(config.is.null.msg, 
                                    jmeter.name, 
                                    getwd())
          jmeter.is.null %>% stop()
          
        }
      }
    }
  )
  return(out)
}


#' Get Test Type
#' gets test type from pre-defined config names in config.yml file
#'
#' @return : String : Test.Type.Value
#' @export
#'
#' @examples
get.test.type <- function(){
  
  test.type.name <- "test-type"
  
  out <- tryCatch(
    
    expr = {
      
      test.type.data <- var_config %>%
        
        flatten %>%
        
        keep(~ .x$name == test.type.name)
      
      test.type <- test.type.data[[1]]$value
      
    },
    
    error = function(e){
      
      test.type.not.found <- sprintf(config.required.msg, 
                                     test.type.name, 
                                     getwd())
      test.type.not.found %>% stop()
      
    },
    
    finally = function(){
      
      test.type %>% {
        
        if(!is.null(.)) return(.)
        
        else{
          
          test.type.is.null <- sprintf(config.is.null.msg, 
                                       test.type.name, 
                                       getwd())
          test.type.is.null %>% stop()
          
        }
      }
    }
  )
  return(out)
}


#' Get Test Data
#' gets test data from tests folder<Or Defined> in <test_file_name>.yml file
#'
#' @return : List : Test.Data
#' @export
#'
#' @examples
get.test.data <- function(){
  
  out <- tryCatch(
    
    expr = {
      
      test.data <- var_test
      
    },
    
    error = function(e){
      
      stop(e)
      
    },
    
    finally = function(){
      
      test.data %>% {
        
        if(!is.null(.)) return(.)
        
        else{
          
          test.data.is.null <- sprintf(test.is.null.msg, getwd())
          
          test.data.is.null %>% stop()
          
        }
      }
    }
  )
  return(out)
}

#' Get Global Config
#' gets all requested config parameter values in config.yml file.
#' By given param;
#'
#' @param x : String : Config.Name
#'
#' @return : String : Config.Value
#' @export
#'
#' @examples
#' get.global.config(x="export-pdf")
get.global.config <- function(x){
  
  config.name <- x
  
  out <- tryCatch(
    
    expr = {
      
      config.data <- var_config %>%
        
        flatten %>%
        
        keep(~ .x$name == config.name)
      
      config <- config.data[[1]]$value
      
    },
    
    error = function(e){
      
      config.not.found <- sprintf(config.required.msg, 
                                     test.type.name, 
                                     getwd())
      config.not.found %>% stop()
      
    },
    
    finally = function(){
      
      config %>% {
        
        if(!is.null(.)) return(.)
        
        else{
          
          config.is.null <- sprintf(config.is.null.msg, 
                                       test.type.name, 
                                       getwd())
          config.is.null %>% stop()
          
        }
      }
    }
  )
  return(out)
}
