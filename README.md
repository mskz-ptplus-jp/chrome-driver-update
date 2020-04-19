# Chrome Driver Update

## The Repository

Check Google Chrome version and update Chrome Driver.

## System Requirements

- Linux

## Requirement

- Google Chrome

## Run

```sh
sudo ./chrome-driver-update.sh
```

### cron

```sh
sudo sh -c "cat <<EOS> /etc/cron.hourly/chrome-driver-update
${PWD}/chrome-driver-update.sh
EOS"
```

## License

Copyright (c) ptplus.jp All rights reserved.

Licensed under the [Apache-2.0](LICENSE.txt) license.