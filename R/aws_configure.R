aws_configure <- function(configure_function){
  paste("aws configure", configure_function)
}

aws_profile <- function(cmd, profile){
  if (profile != "default")
    paste(cmd, "--profile", profile)
  else
    cmd
}

call_cli <- function(cmd, intern = TRUE){
  system(cmd, intern = intern)
}
