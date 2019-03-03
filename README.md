[![CircleCI](https://circleci.com/gh/mokoaki/qiita_trend_stock/tree/master.svg?style=shield)](https://circleci.com/gh/mokoaki/qiita_trend_stock/tree/master)

### memo

```sh
$ bundle install
$ QIITA_ACCESS_TOKEN=test_token bin/qiita_trend_stock
```

```sh
$ bundle install
$ QIITA_ACCESS_TOKEN=test_token bin/console
```

#### circleci

circleci(cli): https://circleci.com/docs/2.0/local-cli/

```sh
$ circleci update
$ circleci config process .circleci/config.yml > tmp/circleci-config-2.0.yml
$ circleci local execute -c tmp/circleci-config-2.0.yml -env QIITA_ACCESS_TOKEN=test_token
```

### test

```sh
$ bundle install --path vendor/bundle
$ bundle exec rspec
```
