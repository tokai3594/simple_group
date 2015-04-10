module SimpleGroup
  module Extenders
    module GroupItem
      def groupable?
        false
      end

      def groupable
        require 'simple_group/group_item'
        include SimpleGroup::GroupItem

        class_eval do
          def self.groupable?
            true
          end
        end
      end
    end
  end
end