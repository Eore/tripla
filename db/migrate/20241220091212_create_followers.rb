class CreateFollowers < ActiveRecord::Migration[8.0]
  def change
    create_table :followers do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :follower, null: false, foreign_key: { to_table: :users }
      
      t.timestamps
    end

    add_index :followers, [:user_id, :follower_id], unique: true
  end
end
