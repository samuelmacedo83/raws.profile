# raws.profile

[![CRAN\_Status\_Badge](https://www.r-pkg.org/badges/version/raws.profile)](https://cran.r-project.org/package=raws.profile)
<a href="https://www.r-pkg.org/pkg/raws.profile"><img src="https://cranlogs.r-pkg.org/badges/raws.profile?color=brightgreen" style=""></a>

This is an R wrapper from the AWS Command Line Interface that 
provides methods to manage the user configuration on Amazon Web Service. You 
can create as many profiles as you want, manage them, and delete them. The 
profiles created with this tool work with all AWS products such as S3, 
Glacier, and EC2. It also provides a function to automatically install 
AWS CLI, but you can download it and install it manually if you prefer.

To use raws.profile package, you will need an AWS account and create a profile.
To do this, go to your AWS account and generate your credentials on
[IAM Management Console](https://aws.amazon.com/). This process will generate an
access key and a secret key, use them to create a profile. 

## Installation

You can install the released version of raws.profile from [CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("raws.profile")
```

To upgrade to the latest version of raws.profile, run the following 
command and restart your r session:

``` r
devtools::install_github("samuelmacedo83/raws.profile")

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
# Contributing

Did you find a bug or want to help us in a new feature? It's awesome! Please look at our [contributing guideline](.github/CONTRIBUTING.md).

