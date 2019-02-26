# raws.profile 0.1.1.9000 (unreleased)

- "us-east-1" is the region default in `create_profile()`

- Create functions to modify profiles that already exist: `change_access_key()`
`change_secret_key()` and `change_region()`.

- Code refactoring to call AWS CLI
