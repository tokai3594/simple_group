require 'active_record'
require 'database_cleaner/active_record'
require 'simple_group'
require 'pry'

Dir["#{Dir.pwd}/spec/internal/app/models/*.rb"].each(&method(:require))

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    ActiveRecord::Base.establish_connection('adapter' => 'sqlite3', 'database' => ':memory:')
    ActiveRecord::Schema.define do
      create_table :simple_group_combinations, force: true do |t|
        t.references :group_item, polymorphic: true, index: { name: :simple_group_combination_group_item }
        t.references :group, polymorphic: true, index: { name: :simple_group_combination_group }
        t.timestamps
      end

      add_index :simple_group_combinations, [:group_item_id, :group_item_type, :group_id, :group_type],
                unique: true, name: :index_simple_group_combinations

      %i(users fruits animals flowers).each do |table_name|
        create_table table_name, force: true do |t|
          t.string :name
        end
      end

      create_table :my_groups, force: true do |t|
        t.string :name
        t.references :user
      end
    end

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