class SleepLog < ApplicationRecord
  belongs_to :user

  validates :clock_in, presence: true
  validate :clock_out, if: -> { clock_out.present? }

  before_save :set_duration

  private

  def set_duration
    return unless clock_out.present?

    self.duration = clock_out - clock_in
  end
end
