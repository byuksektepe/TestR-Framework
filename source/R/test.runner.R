library(yaml)
library(reshape2)

test_path <- paste0(getwd(), "/tests/")

test_files <- list.files(path=test_path, pattern=".yml", all.files=FALSE, full.names=FALSE)
df <- data.frame()


  
  df <- lapply(test_files, function(x) out <- yaml.load_file(paste0(test_path, test_file)))

  