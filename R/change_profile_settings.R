#' Change profile settings
#'
#' Modify access key, secret key, and region in an existent profile.
#'
#' @param profile The profile-name. If profile was not supplied
#' \code{create_profile()} will create a default profile.
#' @param access_key The access key create by AWS.
#' @param secret_key The secret key create by AWS.
#' @param region The default region
#'
#' @examples
#' \dontrun{
#' # create a default user
#' create_profile(access_key = "my_access_key_1",
#'                secret_key = "123456789",
#'                region = "us-east-1")
#'
#' # verify if the user was created
#' profile_settings()
#'
#' # change region
#' change_region("us-west-1")
#'
#' # verify if the region really change
#' profile_settings()
#'
#' # remove your credentials from this computer
#' delete_all_profiles()
#' }
#'
#' @name change_settings
NULL

#' @rdname change_settings
#' @importFrom magrittr %>%
#' @export
change_access_key <- function(access_key, profile = "default"){
  aws_configure("set") %>%
    aws_parameter("aws_access_key_id", access_key) %>%
    aws_profile(profile) %>%
    call_cli(intern = FALSE)
}

#' @rdname change_settings
#' @importFrom magrittr %>%
#' @export
change_secret_key <- function(secret_key, profile = "default"){
  aws_configure("set") %>%
    aws_parameter("aws_secret_access_key", secret_key) %>%
    aws_profile(profile) %>%
    call_cli(intern = FALSE)
}

#' @rdname change_settings
#' @importFrom magrittr %>%
#' @export
change_region <- function(region, profile = "default"){
  aws_configure("set") %>%
    aws_parameter("region", region) %>%
    aws_profile(profile) %>%
    call_cli(intern = FALSE)
}
