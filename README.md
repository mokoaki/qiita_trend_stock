[![CircleCI](https://circleci.com/gh/mokoaki/qiita_trend_stock/tree/master.svg?style=shield)](https://circleci.com/gh/mokoaki/qiita_trend_stock/tree/master)

memo

circleci(cli): https://circleci.com/docs/2.0/local-cli/

```sh
$ circleci update && circleci build --env QIITA_ACCESS_TOKEN=test_token
```

```sh
$ bundle install --path vendor/bundle
$ bin/qiita_trend_stock
```

test

```sh
$ bundle install --path vendor/bundle
$ bundle exec rspec
```
