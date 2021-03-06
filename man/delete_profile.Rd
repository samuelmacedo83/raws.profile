% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/delete_profile.R
\name{delete_profile}
\alias{delete_profile}
\alias{delete_all_profiles}
\title{Delete profiles}
\usage{
delete_profile(profile = "default")

delete_all_profiles()
}
\arguments{
\item{profile}{A string or a vector of strings with the profiles
to delete.}
}
\description{
These functions delete the profiles created. Use
\code{delete_profile()} to delete one or more profiles and use
\code{delete_all_profiles()} if you want ot delete all of them.
}
\examples{
\dontrun{
# To run these examples you need the AWS CLI, use
# aws_cli_install() if it is not installed.

# default user
create_profile(access_key = "my_access_key_1",
               secret_key = "123456789",
               region = "us-east-1")

# profile_name1
create_profile(profile = "profile_name1",
               access_key = "my_access_key_2",
               secret_key = "987654321",
               region = "us-west-1")

# profile_name2
create_profile(profile = "profile_name2",
               access_key = "my_access_key_3",
               secret_key = "12344321",
               region = "us-west-1")

# profile_name3
create_profile(profile = "profile_name3",
               access_key = "my_access_key_3",
               secret_key = "98766789",
               region = "us-east-1")

# profile_name4
create_profile(profile = "profile_name4",
               access_key = "my_access_key_4",
               secret_key = "192837465",
               region = "us-west-1")

# profile_name5
create_profile(profile = "profile_name5",
               access_key = "my_access_key_5",
               secret_key = "546372819",
               region = "us-east-1")

# delete default profile
delete_profile()

# delete one profile
delete_profile("profile_name1")

# delete two profiles
delete_profile(c("profile_name2", "profile_name3"))

# remove your credentials from this computer
delete_all_profiles()
}
}
