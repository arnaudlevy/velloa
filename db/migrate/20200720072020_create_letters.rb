class CreateLetters < ActiveRecord::Migration[6.0]
  def change
    create_table :letters do |t|
      t.date :starting_at
      t.date :ending_at
      t.string :title

      t.timestamps
    end
  end
end
