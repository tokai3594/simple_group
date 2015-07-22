ActiveRecord::Schema.define do
  create_table :simple_group_combinations, force: true do |t|
    t.references :group_item, polymorphic: true
    t.references :group, polymorphic: true
    t.timestamps
  end

  if ActiveRecord::VERSION::MAJOR < 4
    add_index :simple_group_combinations, [:group_item_id, :group_item_type]
    add_index :simple_group_combinations, [:group_id, :group_type]
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