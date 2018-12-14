#' Title
#'
#' @export
aws_version <- function(){
  tryCatch(system("aws --version", intern = TRUE, ignore.stderr = TRUE),
           error = function(cond){
             message("AWS CLI is not installed. Use aws_cli_install()")
           }
  )
}
