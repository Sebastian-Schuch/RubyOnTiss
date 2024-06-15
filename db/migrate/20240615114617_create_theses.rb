class CreateTheses < ActiveRecord::Migration[7.0]
  def change
    unless table_exists?(:theses)
      create_table :theses do |t|
        t.string :title
        t.text :description

        t.timestamps
      end
    end
  end
end
