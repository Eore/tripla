class User < ApplicationRecord
  has_many :sleep_logs
  has_many :follows, dependent: :destroy

  validates :name, presence: true
end
