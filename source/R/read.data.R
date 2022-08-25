# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #


library(yaml)
library(reshape2)



read.test.data <- function(){
  
  test_path <- paste0(getwd(), "/tests/")
  
  df_test <- data.frame()
  
  test_files <- list.files(path=test_path, pattern=".yml", all.files=FALSE, full.names=FALSE)
  
  
  test_list <- lapply(test_files,
                        function(x) out <- yaml.load_file(paste0(test_path, x)))
  
  return(df_test <- melt(test_list))
  
}


read.config.data <- function(){
  
  config_path <- paste0(getwd(), "/config.yml")
  
  df_config <- data.frame()
  
  config_file <- yaml.load_file(config_path)
  
   return(df_config <- melt(config_file))
}

var_test <- read.test.data()
var_config <- read.config.data()

params <- var_config[var_config$L1 == 'parameters',]
params <- params[, colSums(is.na(params)) != nrow(params)]

data_params <- reshape(params,direction = 'wide',timevar = 'L2',idvar = 'L1')


  