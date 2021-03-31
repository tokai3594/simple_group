class SimpleGroupMigration < ActiveRecord::Migration<%= migration_version %>
  def self.up
    create_table :simple_group_combinations do |t|
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
  end

  def self.down
    drop_table :simple_group_combinations
  end
end