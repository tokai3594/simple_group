class User < ActiveRecord::Base
  has_many :my_groups
end