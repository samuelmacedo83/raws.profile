#' Delete profiles
#'
#' These functions delete the profiles created. Use
#' \code{delete_profile()} to delete one or more profiles and use
#' \code{delete_all_profiles()} if you want ot delete all of them.
#'
#' @param profile A string or a vector of strings with the profiles
#' to delete.
#'
#' @examples
#' \dontrun{
#' # To run these examples you need the AWS CLI, use
#' # aws_cli_install() if it is not installed.
#'
#' # default user
#' create_profile(access_key = "my_access_key_1",
#'                secret_key = "123456789",
#'                region = "us-east-1")
#'
#' # profile_name1
#' create_profile(profile = "profile_name1",
#'                access_key = "my_access_key_2",
#'                secret_key = "987654321",
#'                region = "us-west-1")
#'
#' # profile_name2
#' create_profile(profile = "profile_name2",
#'                access_key = "my_access_key_3",
#'                secret_key = "12344321",
#'                region = "us-west-1")
#'
#' # profile_name3
#' create_profile(profile = "profile_name3",
#'                access_key = "my_access_key_3",
#'                secret_key = "98766789",
#'                region = "us-east-1")
#'
#' # profile_name4
#' create_profile(profile = "profile_name4",
#'                access_key = "my_access_key_4",
#'                secret_key = "192837465",
#'                region = "us-west-1")
#'
#' # profile_name5
#' create_profile(profile = "profile_name5",
#'                access_key = "my_access_key_5",
#'                secret_key = "546372819",
#'                region = "us-east-1")
#'
#' # delete default profile
#' delete_profile()
#'
#' # delete one profile
#' delete_profile("profile_name1")
#'
#' # delete two profiles
#' delete_profile(c("profile_name2", "profile_name3"))
#'
#' # remove your credentials from this computer
#' delete_all_profiles()
#' }
#' @name delete_profile
NULL

#' @rdname delete_profile
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

#' @rdname delete_profile
#' @export
delete_all_profiles <- function(){
  home <- Sys.getenv("HOME")
  unlink(paste0(home, "/.aws/config"))
  unlink(paste0(home, "/.aws/credentials"))
}

# delete more than one profile
delete_profiles <- function(profile, num_profiles, aws_file){

  for(i in 1:num_profiles){
    delete_one_profile(profile[i], aws_file)
  }
}

# delete a profile
delete_one_profile <- function(profile, aws_file){

  profiles <- profile_available(aws_file)

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
