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
      
      jmeter.not.found <- sprintf("TestR: Config name of '%s' is not found in %s/config.yml file.", 
                              jmeter.name, 
                              getwd())
      jmeter.not.found %>%
        stop()
    },
    
    finally = function(){
      
      jmeter.version %>% {
        
        if(!is.null(.)) return(.) 
        
        else {
          jmeter.is.null <- sprintf("TestR: '%s' is should be not null in %s/config.yml file.", 
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
  
  test_type_data <- var_config %>%
    flatten %>%
    keep(~ .x$name == "test-type")
  
  test_type <- test_type_data[[1]]$value
  return(test_type)
}

get.test.data <- function(){
  
  test_data <- var_test
  
  return(test_data)
  
}