# raws.profile

This package provides tools for manage your profile user for Amazon Web
Service. You can create as many profiles as you want, modify or delete.
The profiles created with this package work for all tool from AWS, like S3, Glacier or ec2.
The AWS CLI is required and raws.profile provides a function for install
it on Windows, Mac OX or Linux.

## Installation

You can install the released version of raws.profile from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("raws.profile")
```

## Installing the AWS CLI

The AWS CLI is required for raws.profile work. You can install using
the function below:

``` r
aws_cli_install()
```

## Creating your profiles

This is a basic example which shows you how to create your profiles:

``` r
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

# show the profiles created
list_profiles()
```

## Deleting your profiles

You can delete one or more profiles using `delete_profile()`.

``` r
# delete default profile
delete_profile()

# delete one profile
delete_profile("profile_name1")

# delete two profiles
delete_profile(c("profile_name2", "profile_name3"))

# show the profiles remained
list_profiles()
```

## Remove your credentials from the computer

For security, it is a good pratice to remove your credentials from your computer when you finish your work. 


``` r
# remove all profiles saved
delete_all_profiles()

# show the profiles remained
list_profiles()
```


