module SimpleGroup
  module Group
    def self.included(base)
      base.class_eval do
        belongs_to :group, polymorphic: true
        has_many :combinations, class_name: 'SimpleGroup::Combination', as: :group, dependent: :destroy, inverse_of: :group do
          def group_items
            includes(:group_item).map(&:group_item)
          end
        end
      end
    end

    def include?(model)
      raise SimpleGroup::GroupNotAllowError unless model.class.groupable?
      SimpleGroup::Combination.exists?(group: self, group_item: model)
    end

    def exclude?(model)
      !include?(model)
    end

    def add(model)
      raise SimpleGroup::GroupNotAllowError unless model.class.groupable?
      SimpleGroup::Combination.new(group: self, group_item: model).save
    end

    def remove(model)
      raise_error unless model.class.groupable?
      group = SimpleGroup::Combination.where(
          group_type: self.class,
          group_id: self,
          group_item_type: model.class,
          group_item_id: model
      ).first
      if group.present?
        group.destroy
      else
        false
      end
    end

    def for_type(klass)
      self.combinations.for_type(klass)
    end

    def count
      self.combinations.count
    end
  end
end