# Production Chain

A rails gem that incorporate common rake tasks

### Rails 3
Rake tasks are automatically loaded in a rails environment.

### Rails 2
Rake tasks are not automatically loaded in your Rails 2 application.
To get them, add this line to your project `Rakefile`:

```ruby
require 'production_chain/tasks'
```

## Capistrano

Capistrano tasks were extracted into their own gem,
[capistranovelys](https://github.com/novelys/capistranovelys).
