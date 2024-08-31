class User < ApplicationRecord
  belongs_to :department

  enum position: { intern: 0, staff: 10, manager: 20, executive: 30 }
  enum state: { enable: 0, disable: 1 }

  scope :order_desc, lambda { order( "users.id DESC" ) }
  scope :enabled, -> { where(state: :enable) }

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w\-._]+@[\w\-._]+\.[A-Za-z]+(?:,[\w\-._]+@[\w\-._]+\.[A-Za-z]+)*\z/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end
