# simple_group

simple_group gem is able to add group function to ActiveRecord.

[![Code Climate](https://codeclimate.com/github/patorash/simple_group/badges/gpa.svg)](https://codeclimate.com/github/patorash/simple_group)
[![Test Coverage](https://codeclimate.com/github/patorash/simple_group/badges/coverage.svg)](https://codeclimate.com/github/patorash/simple_group)

## Installation

### Rails 5.0+

Add this line to your application's Gemfile:

```ruby
gem 'simple_group'
```

And then execute:

    $ bundle install

### Database Migrations

simple_group uses a simple_group_combinations table to store all group information.
To genarate and run the migration just use.

    $ bin/rails g simple_group:migration
    $ bin/rake db:migrate

## Usage

### Group item model

Animal model

```ruby
class Animal < ActiveRecord::Base
  groupable
  validates :name, presence: true
end
```

Fruit model

```ruby
class Fruit < ActiveRecord::Base
  groupable
  validates :name, presence: true
end
```


### Group model

```ruby
class MyGroup < ActiveRecord::Base
  add_group_function

  validates :name, presence: true
  validates :user, presence: true
end
```

### Example

```ruby
user = User.create(name: 'Taro')
group = MyGroup.create(name: 'Animals', user: user)

# group add a dog
dog = Animal.create(name: 'dog')
group.add(dog)

# cat add to group
cat = Animal.create(name: 'cat')
cat.add_to_group(group)

# group remove a dog
group.remove(dog)

# item list in group
group.group_items

# Only animal
group.for_type(Animal)

# Only fruit
group.for_type(Fruit)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/patorash/simple_group/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
