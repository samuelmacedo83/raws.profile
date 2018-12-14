#' Install AWS CLI
#'
#' This function download and install the AWS CLI. For Linux and Mac is
#' necessary Python 2.6.5 or greater. You can also install the CLI
#' manually, see \url{https://aws.amazon.com/cli/}
#'
#' @export
aws_cli_install <- function(){

  if (!Sys.which("aws") == ""){
    aws_version <- aws_version()
    message("AWS CLI is already installed.")
  } else if (Sys.getenv("SystemRoot") == "C:\\WINDOWS"){ # windows
      if (Sys.getenv("PROCESSOR_ARCHITECTURE") == "x86"){
        aws_cli_windows("https://s3.amazonaws.com/aws-cli/AWSCLI32.msi",
                        "AWSCLI32.msi")
      } else {
        aws_cli_windows("https://s3.amazonaws.com/aws-cli/AWSCLI64.msi",
                        "AWSCLI64.msi")
      }
    } else{# linux or mac
    if (!Sys.which("python3") == "") {
      aws_cli_pip(python_version = 3)
    } else if (!Sys.which("python") == "") {
      aws_cli_pip(python_version = "")
    } else {
      stop("Python is required. ",
           "Please, look at https://www.python.org/downloads/")
    }
  }
}

# instalattion on linux and mac
aws_cli_pip <- function(python_version){

  pip <- paste0("pip", python_version)

  if (!Sys.which(pip) == "") {
    message("Downloading AWS CLI")
    system(paste(pip, "install awscli"))
  } else {
    stop(pip, " is required. ",
         "Please, look at https://pip.pypa.io/en/stable/installing/")
  }
  message("Instalattion complete.")
}

# installation on windows
aws_cli_windows <- function(aws_cli_url,
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
