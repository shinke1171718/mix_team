class Group < ApplicationRecord
  belongs_to :event
  has_many :members, dependent: :destroy
  has_many :users, through: :members
end
