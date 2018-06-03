[![CircleCI](https://circleci.com/gh/mokoaki/qiita_trend_stock/tree/master.svg?style=shield)](https://circleci.com/gh/mokoaki/qiita_trend_stock/tree/master)

memo

circleci(cli): https://circleci.com/docs/2.0/local-cli/

```sh
$ circleci update && circleci build --env STOCKED_ITEM_UUID=43b566faf2e8443ae413 --env QIITA_ACCESS_TOKEN=123456789abcdef
```

```sh
$ bundle install --path vendor/bundle --without development
$ bundle exec ruby qiita_trend_stock.rb
```

test

```sh
$ bundle install --path vendor/bundle
$ bundle exec rspec
```
