memo

```sh
$ bundle install --path vendor/bundle
$ bundle install --path vendor/bundle --without development test
```

```sh
$ circleci update && circleci build --env qiita_access_token=1234567890abcdef --env stocked_item_uuid=61325fefd39377da0657
```

test

```sh
$ bundle exec rspec spec
```
