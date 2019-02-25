#' User profile configuration
#'
#' Functions to configure and visualize the user credentials. You can
#' see a profile settings using \code{profile_settings()} and vizualise
#' all profiles created using \code{list_profiles()}. The AWS CLI
#' saves your credentials in ~/.aws folder, so, for security reasons,
#' delete your credentials when you finish your work using
#' \code{delete_all_profiles()}.
#'
#' @param profile The profile-name. If profile was not supplied
#' \code{create_profile()} will create a default profile.
#' @param access_key The access key create by AWS.
#' @param secret_key The secret key create by AWS.
#' @param region The default region
#'
#' @examples
#' \dontrun{
#' # To run these examples you need the AWS CLI, use
#' # aws_cli_install() if it is not installed.
#'
#' # create a default user
#' create_profile(access_key = "my_access_key_1",
#'                secret_key = "123456789",
#'                region = "us-east-1")
#'
#' # verify if the user was created
#' profile_settings()
#'
#' # you can also create a user with a profile name
#' create_profile(profile = "profile_name",
#'                access_key = "my_access_key_2",
#'                secret_key = "987654321",
#'                region = "us-west-1")
#'
#' # verify if the user was created
#' profile_settings(profile = "profile_name")
#'
#' # remove your credentials from this computer
#' delete_all_profiles()
#' }
#'
#' @name aws_profile
NULL

#' @rdname aws_profile
#' @export
create_profile <- function(profile = "default",
                           access_key = NULL,
                           secret_key = NULL,
                           region = "us-east-1"){

 command <- "aws configure set"
 profile <- aws_profile(profile)

 if (!is.null(access_key)){
   system(paste(command, "aws_access_key_id", access_key, profile))
 }

 if (!is.null(secret_key)){
   system(paste(command, "aws_secret_access_key", secret_key, profile))
 }

 if (!is.null(region)){
   system(paste(command, "region", region, profile))
 }
}

#' @rdname aws_profile
#' @export
profile_settings <- function(profile = "default"){

  profiles <- list_profiles()

  if (!any(profiles == profile)){
    stop(paste("The", profile , "profile does not exist."),
         call. = FALSE)
  }

  if (profile == "default"){
    cmd_profile <- ""
  } else {
    cmd_profile <- paste("--profile", profile)
  }

  configure_list <- system(paste("aws configure list", cmd_profile),
                           intern = TRUE)

  name <- NULL
  value <- NULL
  # the two first lines are the header and ----
  for (i in 3:length(configure_list)){
    name[i - 2] <- stringr::str_trim(substr(configure_list[i], 1, 10))
    value[i - 2] <- stringr::str_trim(substr(configure_list[i], 16, 35))
  }

  # AWS CLI put the value for default as <not set>
  if (profile == "default"){
    value[1] <- "default"
  }

  tibble::tibble(name, value)
}
