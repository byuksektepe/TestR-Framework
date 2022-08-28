# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #

source(paste0(getwd(), "/R/read.data.R"))

library(purrr)
library(magrittr)


#' Get JMeter Version
#' gets jmeter version from pre-defined config names in config.yml file
#'
#' @return : String : Jmeter.Version
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
#' @return : String : Test.Type
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