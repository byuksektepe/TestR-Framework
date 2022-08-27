# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #

source(paste0(getwd(), "/R/read.data.R"))

library(purrr)
library(magrittr)


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
          jmeter.is.null <- sprintf(config.not.null.msg, 
                                    jmeter.name, 
                                    getwd())
          jmeter.is.null %>% stop()
          
        }
      }
    }
  )
  return(out)
}

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
          
          test.type.is.null <- sprintf(config.not.null.msg, 
                                       test.type.name, 
                                       getwd())
          test.type.is.null %>% stop()
          
        }
      }
    }
  )
  return(out)
}

get.test.data <- function(){
  
  test_data <- var_test
  
  return(test_data)
  
}