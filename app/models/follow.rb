class Follow < ApplicationRecord
  belongs_to :user

  validates :user_id, uniqueness: { scope: :follow_id }
end
