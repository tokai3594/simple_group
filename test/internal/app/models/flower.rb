class Flower < ActiveRecord::Base
  validates :name, presence: true
end