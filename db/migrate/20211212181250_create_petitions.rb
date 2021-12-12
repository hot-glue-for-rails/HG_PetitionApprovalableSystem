class CreatePetitions < ActiveRecord::Migration[6.1]
  def change
    create_table :petitions do |t|
      t.integer :user_id
      t.text :question1
      t.text :question2
      t.text :question3
      t.timestamp :accepted_at
      t.timestamp :rejected_at

      t.timestamps
    end
  end
end
