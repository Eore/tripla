class SleepLog < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validate :clock_out, if: -> { clock_out.present? }

  def duration
    return 0 unless clock_in.present? && clock_out.present?

    clock_out - clock_in
  end
end
