module SimpleGroup
  class Combination < ::ActiveRecord::Base
    self.table_name = 'simple_group_combinations'

    if ::ActiveRecord::VERSION::MAJOR < 4
      attr_accessible :group_id, :group_type,
                      :group_item_id, :group_item_type,
                      :group, :group_item
    end

    belongs_to :group, polymorphic: true
    belongs_to :group_item, polymorphic: true

    scope :for_type, lambda { |klass| where(group_item_type: klass) }
    scope :by_type,  lambda { |klass| where(group_type: klass) }

    validates :group_item_id, presence: true
    validates :group_id, presence: true
    validates_uniqueness_of :group_id, scope: [:group_type, :group_item_id, :group_item_type]
  end

  class GroupNotAllowError < Exception; end
end