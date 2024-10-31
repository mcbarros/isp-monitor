# ISP Monitor

Small project to manage and monitor ISP providers interacting with MikroTik router through [RouterOS API](https://rubygems.org/gems/routeros-api)

This project is meant to be used as selfhosted app, be careful with any other use.

## Active Record encryption

We use the Active Record Encryption to encrypt all password saved on the database. To run this project, make sure to have the keys setup by running `rails db:encryption:init` and copying the result to your credentails file `EDITOR=nano rails credentials:edit`. Since this is supposed to be ran on a self hosted environment, `master.key` was committed to the repo, if you want to harden your deploy, make sure to update both the master key and the encrypted credentials.

## Recurrent checks (running on the background every 5 minutes)

This project uses `delayed_job` to perform background checks every 5 minutes on the routers. This behavior can be enabled/disabled on the router config form. Since we are using a background job, we need a way kick off a process that will work on the background. Here is a simple docker compose that will run the rails server and kick off the process on a separate container:

```
name: isp-monitor
services:
  isp-monitor:
    image: mcbarros/isp-monitor:latest
    volumes:
      - type: bind
        source: /my-host-path/storage
        target: /rails/storage
    network_mode: host
  bg-runner:
    image: mcbarros/isp-monitor:latest
    cmd: ["./bin/rails", "jobs:work"]
    volumes:
      - type: bind
        source: /my-host-path/storage
        target: /rails/storage
    network_mode: host
```

### Email notification

To set up your email notification, you need to configure the SMTP server using environment variables:
- RAILS_SMTP_HOST - required
- RAILS_SMTP_PORT - optional, default 587
- RAILS_SMTP_DOMAIN - optional
- RAILS_SMTP_USERNAME - required
- RAILS_SMTP_PASSWORD - required
- RAILS_SMTP_AUTH_TYPE - optional, default plain

## Planned Features

- [ ] Authentication and a small configuration screen to configure a default user

## Development

This project uses [lefthook](https://github.com/evilmartians/lefthook) to manage git hooks. Just run `lefthook install` after the `bundle install` to set every thing up.

You also need `yarn` installed to the javascript and css build work. To run the application in dev use `bin/dev`.

## License

The app is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
