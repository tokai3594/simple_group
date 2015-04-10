$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'simple_group'
require 'bundler/setup'
require 'combustion'
require 'database_rewinder'

Combustion.initialize! :active_record

RSpec.configure do |config|
  config.before :suite do
    DatabaseRewinder.clean_all
  end

  config.after :each do
    DatabaseRewinder.clean
  end
end

shared_context 'prepare_data' do
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