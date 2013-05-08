# Production Chain

A rails gem that incorporate various libs, recipes and tasks

## Rake

### Rails 3
Rake tasks are automatically loaded in a rails environment.

### Rails 2
Rake tasks are not automatically loaded in your Rails 2 application. To get them, add this line to your project `Rakefile`:
```ruby
require 'production_chain/tasks'
```

## Capistrano

Capistrano tasks are *not* automatically loaded. You have to add to your `config/deploy.rb` file:

```ruby
require 'bundler/setup'
require 'production_chain/capistrano'
```

### Known issues

This gem assumes you have the `s3` gem installed, while not explicitly requiring either in the gemspec or in the Gemfile. `master` has the code and the references to s3 removed, but not the published gem yet.
