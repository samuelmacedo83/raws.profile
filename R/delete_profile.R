#' Title
#'
#' @param profile
#'
#' @export
delete_profile <- function(profile = "default"){

  credentials_path <- profile_path("credentials")
  config_path <- profile_path("config")

  if (!file.exists(credentials_path) & !file.exists(config_path)){
    stop("There is no profiles saved.")
  }

  num_profiles <- length(profile)

  if (file.exists(credentials_path)){
    if (num_profiles == 1){
      delete_one_profile(profile, "credentials")
    } else {
      delete_profiles(profile, num_profiles, "credentials")
    }
  }

  if (file.exists(config_path)){
    if (num_profiles == 1){
      delete_one_profile(profile, "config")
    } else {
      delete_profiles(profile, num_profiles, "config")
     }
   }

}

# delete more than one profile
delete_profiles <- function(profile, num_profiles, aws_file){

  for(i in 1:num_profiles){
    delete_one_profile(profile[i], aws_file)
  }
}

# delete a profile
delete_one_profile <- function(profile, aws_file, write = TRUE){

  profiles <- list_profiles(aws_file)

  if (any(profiles == profile)){
    profile_path <- profile_path(aws_file)
    profile_file <- as.character(utils::read.table(profile_path,
                                                   sep = "\n")$V1)
    profiles_name_position <- stringr::str_which(profile_file, "\\[")

    if (profiles[1,1] == profile){ # first
      begin <- 1
      end <- profiles_name_position[2] - 1
    } else if (profiles[nrow(profiles), 1] == profile){ # last
      begin <- profiles_name_position[nrow(profiles)]
      end <- length(profile_file)
    } else { # middle
      profile_position <-  which(profiles$profiles == profile)
      begin <- profiles_name_position[profile_position]
      end <- profiles_name_position[profile_position + 1] - 1
    }

    write(profile_file[-(begin:end)],
          file = profile_path(aws_file))
  } else {
    warning(paste0("Profile ", profile, " does not exist in ",
                   aws_file, " file."),
            call. = FALSE)
  }

}


