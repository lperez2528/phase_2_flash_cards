class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :correct_guess_count, default: 0
      t.integer :user_id
      t.integer :deck_id

      t.timestamps
    end
  end
end
