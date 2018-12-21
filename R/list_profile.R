#' The profile names saved
#'
#' The AWs CLI creates two profile files: credentials
#' and config. Use \code{list_profiles("config")} if you want to see
#' the profile names in config file.
#'
#' @param aws_file A string: "credentials" or "config".
#' @import stringr
#' @return A tibble with the profile names available.
#' @examples
#'  \dontrun{
#'  # use this for profile names available
#'  list_profiles()
#'
#'  # use this if want to see the profiles on config file
#'  list_profiles("config")
#'  }
#' @export
list_profiles <- function(aws_file = "credentials"){

  profile_path <- profile_path(aws_file)

  if (!file.exists(profile_path)){
    message("There is no profiles saved")
  } else {
    profiles <- utils::read.table(profile_path,
                                  sep = "\n")$V1 %>%
      as.character() %>%
      str_subset("\\[") %>%
      str_remove("\\[") %>%
      str_remove("\\]")

    if (aws_file == "config"){
      profiles <- profiles %>%
        str_remove("profile ")
    }

    tibble::data_frame(profiles = profiles)
  }
}
