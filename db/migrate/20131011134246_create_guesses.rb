class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.string :answer_input
      t.integer :round_id
      t.integer :card_id

      t.timestamps
    end
  end
end
