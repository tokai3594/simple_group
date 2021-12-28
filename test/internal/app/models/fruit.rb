class Fruit < ActiveRecord::Base
  groupable
  validates :name, presence: true
end