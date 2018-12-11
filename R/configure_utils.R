#
aws_profile <- function(profile){

  if (profile == "default"){
    profile <- ""
  } else {
    profile <- paste("--profile", profile)
  }
  profile
}
