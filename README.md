SpreeBulkStoreCredits
=====================

This extension allows the admin to provide store credits in bulk to users through csv import or multi-select user list from the users admin panel.

Try Spree Bulk Store Credit for Spree 3-4 with direct deployment on Heroku:

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/himanshumishra31/teststorecredits)

## Installation

1. Add this extension to your Gemfile with this line:
  ```ruby
  gem 'spree_bulk_store_credits', github: '[your-github-handle]/spree_bulk_store_credits'
  ```

2. Install the gem using Bundler:
  ```ruby
  bundle install
  ```

3. Copy & run migrations
  ```ruby
  bundle exec rails g spree_bulk_store_credits:install
  ```

4. Restart your server

  If your server was running, restart it so that it can find the assets properly.

## Testing

First bundle your dependencies, then run `rake`. `rake` will default to building the dummy app if it does not exist, then it will run specs. The dummy app can be regenerated by using `rake test_app`.

```shell
bundle
bundle exec rake
```

When testing your applications integration with this extension you may use it's factories.
Simply add this require statement to your spec_helper:

```ruby
require 'spree_bulk_store_credits/factories'
```

## See It In Action
<a href="http://www.youtube.com/watch?feature=player_embedded&v=iAMM7npK3vg
" target="_blank"><img src="http://img.youtube.com/vi/iAMM7npK3vg/0.jpg" 
alt="Youtube Video Tutorial" /></a>

## Credits

[![vinsol.com: Ruby on Rails, iOS and Android developers](http://vinsol.com/vin_logo.png "Ruby on Rails, iOS and Android developers")](http://vinsol.com)

Copyright (c) 2018 [vinsol.com](http://vinsol.com "Ruby on Rails, iOS and Android developers"), released under the New MIT License
