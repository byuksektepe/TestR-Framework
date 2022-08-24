library(yaml)

test_path = paste0(getwd(), "/tests/")

data <- yaml.load_file(paste0(test_path, "example_test.yml"))


data$`Test-Scenario-1`