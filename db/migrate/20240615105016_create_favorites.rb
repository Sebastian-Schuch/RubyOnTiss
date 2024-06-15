class CreateFavorites < ActiveRecord::Migration[7.0]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :favoritable, polymorphic: true, null: false
      t.text :keywords
      t.text :personal_notes

      t.timestamps
    end
  end
end
