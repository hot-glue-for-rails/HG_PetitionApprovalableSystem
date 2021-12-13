class CreatePetitions < ActiveRecord::Migration[6.1]
  def change
    create_table :petitions do |t|
      t.integer :user_id
      t.text :answer1
      t.text :answer2
      t.text :answer3
      t.timestamp :accepted_at
      t.timestamp :rejected_at

      t.timestamps
    end
  end
end
