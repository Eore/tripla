class CreateSleepLogs < ActiveRecord::Migration[8.0]
  def change
    create_table :sleep_logs do |t|
      t.timestamp :clock_in
      t.timestamp :clock_out
      t.references :user, null: false, foreign_key: true
    end
  end
end
