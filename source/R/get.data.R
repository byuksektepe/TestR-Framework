# ========================================================================= #
# TestR Framework Copyright © 2022 Berkant Yüksektepe                       #
# Licensed under the MIT License.                                           #
# ========================================================================= #

source(paste0(getwd(), "/source/R/read.data.R"))

library(purrr)
library(magrittr)


get.jmeter.version <- function(){
  
  jmeter_data <- var_config %>%
    flatten %>%
    keep(~ .x$name == "Jmeter-version")
  
  jmeter_version <- jmeter_data[[1]]$value
  return(jmeter_version)
}

var <- get.jmeter.version()