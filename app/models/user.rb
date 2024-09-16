class User < ApplicationRecord
  belongs_to :department
  has_many :members
  has_many :groups, through: :members

  enum position: { intern: 0, staff: 10, manager: 20, executive: 30 }
  enum state: { enable: 0, disable: 1 }

  scope :order_desc, -> { order( "users.id DESC" ) }
  scope :enabled, -> { where(state: :enable) }
  scope :ordered_position, -> {
    joins(:department).order('departments.position ASC')
  }

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w\-._]+@[\w\-._]+\.[A-Za-z]+(?:,[\w\-._]+@[\w\-._]+\.[A-Za-z]+)*\z/
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
end
