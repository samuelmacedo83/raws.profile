context("Tests for raws.profile")

test_that("Installation works", {
  skip_on_cran()
  result <- stringr::str_detect(Sys.which("aws"), "aws")
  expect_true(result)
})

test_that("Create_profile works", {
  skip_on_cran()
  delete_all_profiles()
  create_profile(access_key = "1234",
                 secret_key = "1234",
                 region = "nowhere1")

  create_profile(profile = "john",
                 access_key = "4321",
                 secret_key = "4321",
                 region = "nowhere2")

  create_profile(profile = "doe",
                 access_key = "4132",
                 secret_key = "4132",
                 region = "nowhere3")

  # test if the credentials and config were created
    if(file.exists(paste0(Sys.getenv("HOME"),"/.aws/credentials")) &
       file.exists(paste0(Sys.getenv("HOME"),"/.aws/config"))){
    result <- TRUE
  } else {
    result <- FALSE
  }

  expect_true(result, info = "Credentials or config was not created")

  # test if the profile were created
  profiles <- list_profiles()
  expect_equal(profiles$profiles, c("default", "john", "doe"),
               info = "Profiles were not created correctly")

  # test change_*
  change_access_key("5678")
  change_secret_key("5678")
  change_region("recife")

  change_access_key("8765", "john")
  change_secret_key("8765", "john")
  change_region("recife", "john")

  default_profile <- profile_settings()
  john_profile <- profile_settings("john")

  default_gt <- c("default", "****************5678",
                  "****************5678", "recife")
  john_gt <- c("john", "****************8765",
                "****************8765", "recife")
  expect_equal(default_profile$value, default_gt,
               info = "change default profile is not working.")
  expect_equal(john_profile$value,john_gt,
               info = "change profile is not working.")


  # test delete_profile()
  delete_profile(c("john", "doe"))
  profiles <- list_profiles()
  expect_equal(profiles$profiles, "default",
               info = "delete_profile() is not working.")

  # test delete_all_profiles()
  delete_all_profiles()

 if(file.exists(paste0(Sys.getenv("HOME"),"/.aws/credentials")) &
       file.exists(paste0(Sys.getenv("HOME"),"/.aws/config"))){
    result <- FALSE
  } else {
    result <- TRUE
  }

  expect_true(result, info = "delete_all_profiles is not working")
})

