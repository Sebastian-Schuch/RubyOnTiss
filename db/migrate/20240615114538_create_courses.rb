class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.string :title
      t.text :short
      t.string :detail_url
      t.string :custom_id, null: false

      t.timestamps
    end

    add_index :courses, :custom_id, unique: true
  end
end
