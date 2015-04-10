class SimpleGroupMigration < ActiveRecord::Migration
  def self.up
    create_table :simple_group_combinations do |t|
      t.references :group_item, polymorphic: true
      t.references :group, polymorphic: true
      t.timestamp
    end

    if ActiveRecord::VERSION::MAJOR < 4
      add_index :simple_groups, [:group_item_id, :group_item_type]
      add_index :simple_groups, [:group_id, :group_type]
    end
  end

  def self.down
    drop_table :simple_group_combinations
  end
end