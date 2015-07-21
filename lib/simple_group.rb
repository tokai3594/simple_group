require 'active_record'
require 'active_support/inflector'

require "simple_group/version"

module SimpleGroup
  if defined?(ActiveRecord::Base)
    require 'simple_group/extenders/group'
    require 'simple_group/extenders/group_item'
    require "simple_group/group"
    require "simple_group/group_item"
    require 'simple_group/combination'
    ActiveRecord::Base.extend SimpleGroup::Extenders::Group
    ActiveRecord::Base.extend SimpleGroup::Extenders::GroupItem
  end
end
