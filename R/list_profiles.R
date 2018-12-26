#' The profile names saved
#'
#' The AWs CLI creates two profile files: credentials
#' and config. This function return the profiles availables in both
#' files.
#'
#' @return A tibble with the profile names available.
#' @examples
#'  \dontrun{
#'  # use this for profile names available
#'  list_profiles()
#'  }
#' @export
list_profiles <- function(){

  credentials_profile <- profile_available("credentials")
  config_profile <- profile_available("config")

  if (is.null(credentials_profile) & is.null(config_profile)){
    stop("There is no profiles saved", call. = FALSE)
  }

  unique(rbind(credentials_profile,
               config_profile))
}

#' @import stringr
profile_available <- function(aws_file){

  profile_path <- profile_path(aws_file)

  if(!file.exists(profile_path)){
    profile_list <- NULL
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

    profile_list <- tibble::data_frame(profiles = profiles)
  }

  profile_list
}

