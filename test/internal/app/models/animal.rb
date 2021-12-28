class Animal < ActiveRecord::Base
  groupable
  validates :name, presence: true
end