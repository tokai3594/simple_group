class MyGroup < ActiveRecord::Base
  belongs_to :user

  add_group_function

  validates :name, presence: true
  validates :user, presence: true
end