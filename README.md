# ISP Monitor

Small project to manage and monitor ISP providers interacting with MikroTik router through [RouteOS API](https://rubygems.org/gems/routeros-api)

This project is meant to be used as selfhosted app, be careful with any other use.

## Active Record encryption

We use the Active Record Encryption to encrypt all password saved on the database. To run this project, make sure to have the keys setup by running `rails db:encryption:init` and copying the result to your credentails file `EDITOR=nano rails credentials:edit`. Since this is supposed to be ran on a self hosted environment, `master.key` was committed to the repo, if you want to harden your deploy, make sure to update both the master key and the encrypted credentials.

## Planned Features

- [ ] Background monitor of any status change on the routes
    - [ ] Configurable email notification when a route becomes active or inactive
- [ ] Authentication and a small configuration screen to configure a default user
- [ ] Possible implementation of a ping feature to test ISPs
- [ ] Helpers for the UI

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
