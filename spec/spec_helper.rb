require 'rubygems'
require 'simple_group'
require 'bundler/setup'
require 'combustion'
require 'database_cleaner/active_record'
require 'pry'

Combustion.initialize! :active_record

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before :each do
    DatabaseCleaner.start
  end

  config.after :each do
    DatabaseCleaner.clean
  end
end

RSpec.shared_context 'prepare_data' do
  let(:user) { User.create!(name: 'user') }
  %i(orange grape apple).each do |fruit_name|
    let(fruit_name) { Fruit.create!(name: fruit_name.to_s) }
  end

  %i(dog cat pig).each do |animal_name|
    let(animal_name) { Animal.create!(name: animal_name.to_s) }
  end

  %i(sunflower tulip pansy).each do |flower_name|
    let(flower_name) { Flower.create!(name: flower_name.to_s) }
  end

  let(:my_group) { MyGroup.create!(name: 'Favorites', user: user) }
end