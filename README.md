# Production Chain

A rails gem that incorporate various libs, recipes and tasks

## Rake

Rake tasks are automatically loaded in a rails environment

## Capistrano

Capistrano tasks are *not* automatically loaded. You have to add to your `config/deploy.rb` file:

```ruby
require 'bundler/setup'
require 'production_chain/capistrano'
```

### Modules available

There is currently two modules available :

* `load 'recipes/sphinx'`, for Thinking Sphinx
* `load 'recipes/unicorn`, when using unicorn as web server

Look at each file in order to know if it is suitable for your use,
what is set and what can be overridden.
