class AddFieldsToProjects < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:projects, :title)
      add_column :projects, :title, :string
    end

    unless column_exists?(:projects, :short)
      add_column :projects, :short, :text
    end

    unless column_exists?(:projects, :detail_url)
      add_column :projects, :detail_url, :string
    end

    unless column_exists?(:projects, :detail_url_rest)
      add_column :projects, :detail_url_rest, :string
    end
  end
end
