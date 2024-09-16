class Member < ApplicationRecord
  belongs_to :event
  belongs_to :group, optional: true
  belongs_to :user
end
