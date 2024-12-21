class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :user_id, uniqueness: { scope: :follow_id }
  validate :cannot_follow_self

  private

  def cannot_follow_self
    errors.add(:follow_id, "You cannot follow yourself") if user_id == follow_id
  end
end
