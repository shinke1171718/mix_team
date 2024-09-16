class Event < ApplicationRecord
  has_many :groups, dependent: :destroy
  has_many :members, dependent: :destroy
  has_many :users, through: :members

  validates :title, presence: true, length: { maximum: 15 }
  validates :event_date, presence: true
  validates :max_group_size, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 2 }
  validates :min_group_size, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 2 }
  validates :memo, length: { maximum: 150 }
  validate :min_group_size_should_be_less_than_max_group_size
  validate :max_and_min_group_size_difference

  enum state: { disable: 0, entry: 1, closed: 2 }

  scope :active, -> { where.not(state: :disable) }
  scope :ordered_desc, -> { order(created_at: :desc) }

  private

  def min_group_size_should_be_less_than_max_group_size
    unless min_group_size.present? && max_group_size.present?
      errors.add(:base, "最小グループサイズおよび最大グループサイズは必須です")
      return
    end
  
    if min_group_size > max_group_size
      errors.add(:min_group_size, "は最大グループサイズ以下である必要があります")
    end
  
    enabled_user_count = User.enabled.count
    if max_group_size > enabled_user_count
      errors.add(:max_group_size, "は現在の有効なユーザー数以下である必要があります（#{enabled_user_count}人以下）")
    end
  end

  def max_and_min_group_size_difference
    if max_group_size.present? && min_group_size.present? && (max_group_size - min_group_size > 1)
      errors.add(:base, "最小グループサイズと最大グループサイズの差は1以内にしてください")
    end
  end
    
end
