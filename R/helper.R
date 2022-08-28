
Create.Console.Message.sprintf <- function(msg, name){
  msg %>% {
    sprintf(., name) %>% 
      yellow() %>% 
      cat()
  }
}

Create.Console.Message <- function(msg){
  msg %>% {
    paste0(.) %>%
      yellow() %>% 
      cat()
  }
}