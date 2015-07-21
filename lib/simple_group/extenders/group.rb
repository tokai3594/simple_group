module SimpleGroup
  module Extenders
    module Group
      def added_group_function?
        false
      end

      def add_group_function(*args)
        require 'simple_group/group'
        include SimpleGroup::Group

        class_eval do
          def self.added_group_function?
            true
          end
        end
      end
    end
  end
end