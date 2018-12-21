# input the profile in command line
aws_profile <- function(profile){

  if (profile == "default"){
    profile <- ""
  } else {
    profile <- paste("--profile", profile)
  }
  profile
}

# path for profile credentials or config
profile_path <- function(aws_file){
  home <- Sys.getenv("HOME")
  paste0(home, "/.aws/", aws_file)
}


