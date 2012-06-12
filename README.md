# Production Chain

A rails gem that incorporate various libs, recipes and tasks

## Rake

Rake tasks are automatically loaded in a rails environment

## Capistrano

Capistrano tasks are *not* automatically loaded. You have to add to your `config/deploy.rb` file:

```ruby
require 'bundler/setup'
require 'production_chain'
```

### Known issues

This gem assumes you have the `s3` gem installed, while not explicitly requiring either in the gemspec or in the Gemfile.
