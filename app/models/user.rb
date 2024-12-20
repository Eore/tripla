class User < ApplicationRecord
  has_many :sleep_logs
  has_many :follows, dependent: :destroy
end
