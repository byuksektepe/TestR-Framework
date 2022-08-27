# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #


library(yaml)
library(reshape2)
library(purrr)



read.test.data <- function(){
  
  test_path <- paste0(getwd(), "/tests/")
  
  test_files <- list.files(path=test_path, pattern=".yml", all.files=FALSE, full.names=FALSE)
  
  test_list <- lapply(test_files,
                        function(x) out <- yaml.load_file(paste0(test_path, x)))
  
  return(test_list)
  
}


read.config.data <- function(){
  
  config_path <- paste0(getwd(), "/config.yml")
  
  df_config <- data.frame()
  
  config_file <- yaml.load_file(config_path)
  
   return(config_file)
}


var_test <- read.test.data()
var_config <- read.config.data()



  