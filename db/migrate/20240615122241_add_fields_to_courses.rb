class AddFieldsToCourses < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:courses, :title)
      add_column :courses, :title, :string
    end

    unless column_exists?(:courses, :short)
      add_column :courses, :short, :text
    end

    unless column_exists?(:courses, :detail_url)
      add_column :courses, :detail_url, :string
    end
  end
end
