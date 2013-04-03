# Acfs - *API client for services*

[![Gem Version](https://badge.fury.io/rb/acfs.png)](http://badge.fury.io/rb/acfs) [![Build Status](https://travis-ci.org/jgraichen/acfs.png?branch=master)](https://travis-ci.org/jgraichen/acfs) [![Coverage Status](https://coveralls.io/repos/jgraichen/acfs/badge.png?branch=master)](https://coveralls.io/r/jgraichen/acfs) [![Code Climate](https://codeclimate.com/github/jgraichen/acfs.png)](https://codeclimate.com/github/jgraichen/acfs) [![Dependency Status](https://gemnasium.com/jgraichen/acfs.png)](https://gemnasium.com/jgraichen/acfs)

TODO: Develop asynchronous parallel API client library for service oriented applications.

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'acfs', '0.3.0'

**Note:** Acfs is under development. API may change anytime. No semantic versioning until version `1.0`. Version `1.0`
does not mean complete feature set but stable basic code base.

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install acfs

## Usage

### Attributes

```ruby
class MyModel
  include Acfs::Model

  attribute :name, :string
  attribute :age, :integer, default: 15
end

MyModel.attributes # => { "name" => "", "age" => 15 }

mo = MyModel.new name: 'Johnny', age: 12
mo.name # => "Johnny"
mo.age = '13'
mo.age # => 13
mo.attributes # => { "name" => "Johnny", "age" => 13 }
```

### Service, Model & Collection

```ruby
class MyService < Acfs::Service
  self.base_url = 'http://acc.srv'
end

class User
  include Acfs::Model
  service MyService

  attribute :id, :integer
end

@user = User.find 14

@user.loaded? #=> false

Acfs.run # This will run all queued request as parallel as possible.
         # For @user the following URL will be requested:
         # `http://acc.srv/users/14`

@model.name # => "..."

@users = User.all
@users.loaded? #=> false

Acfs.run # Will request `http://acc.srv/users`

@users #=> [<User>, ...]
```

## TODO

* Develop Library
* Documentation

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Add specs for your feature
4. Implement your feature
5. Commit your changes (`git commit -am 'Add some feature'`)
6. Push to the branch (`git push origin my-new-feature`)
7. Create new Pull Request

## License

MIT License

Copyright (c) 2013 Jan Graichen. MIT license, see LICENSE for more details.
