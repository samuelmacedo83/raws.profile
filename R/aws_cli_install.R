#' Install AWS CLI
#'
#' This function download and install the AWS CLI. For Linux and Mac is
#' necessary Python 2.6.5 or greater. You can also install the CLI
#' manually, see \url{https://aws.amazon.com/cli/}
#'
#' @export
aws_cli_install <- function(){

  if (Sys.getenv("SystemRoot") == "C:\\WINDOWS"){ # windows
    if (dir.exists("C:\\Program Files\\Amazon\\AWSCLI")){
      aws_version <- aws_version()
      message(paste0("AWS cli is already installed under ",
                     aws_version, " version."))
    } else {
      if (Sys.getenv("PROCESSOR_ARCHITECTURE") == "x86"){
        aws_cli_download("https://s3.amazonaws.com/aws-cli/AWSCLI32.msi",
                         "AWSCLI32.msi")
      } else {
        aws_cli_download("https://s3.amazonaws.com/aws-cli/AWSCLI64.msi",
                         "AWSCLI64.msi")
      }

    }
  } else{# linux or mac

  }


}

aws_cli_download <- function(aws_cli_url,
                             aws_system){

  temp_dir <- tempdir()

  message("Downloading AWS CLI")
  download.file(aws_cli_url,
                destfile = paste0(temp_dir, "\\", aws_system),
                method = "curl",
                quiet = TRUE)

  system(paste0("MSIEXEC /i ",
                temp_dir, "\\", aws_system,
                " /passive"),
         intern = TRUE)

  message("Please, close and reopen R to complete",
          " the installation")
}
