#' AWS CLI version
#'
#' This function provides the version of AWS CLI installed. A message
#' to use \code{aws_cli_install()} will be exhibit if the AWS CLI
#' was not found.
#'
#' @export
aws_version <- function(){
  tryCatch(system("aws --version", intern = TRUE, ignore.stderr = TRUE),
           error = function(cond){
             message("AWS CLI is not installed. Use aws_cli_install()")
           }
  )
}
