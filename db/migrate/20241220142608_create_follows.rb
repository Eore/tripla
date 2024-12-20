class CreateFollows < ActiveRecord::Migration[8.0]
  def change
    create_table :follows do |t|
      t.references :user, null: false, foreign_key: { to_table: :users }
      t.references :follow, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end

    add_index :follows, [ :user_id, :follow_id ], unique: true
  end
end
