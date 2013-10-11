class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.integer :correct_guess_count
      t.integer :incorrect_guess_count
      t.integer :user_id
      t.integer :deck_id

      t.timestamps
    end
  end
end
