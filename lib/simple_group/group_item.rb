module SimpleGroup
  module GroupItem

    def self.included(base)
      base.class_eval do
        has_many :combinations, :class_name => 'SimpleGroup::Combination', :as => :group_item, :dependent => :destroy do
          def groups
            includes(:group).map(&:group)
          end
        end
      end
    end

    def add_to_group(group)
      SimpleGroup::Combination.create(group_item: self, group: group)
    end
  end
end