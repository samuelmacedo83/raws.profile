#' Title
#'
#' @export
aws_version <- function(){
  system("aws --version", intern = TRUE)
}


