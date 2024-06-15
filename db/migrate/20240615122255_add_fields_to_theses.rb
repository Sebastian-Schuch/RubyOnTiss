class AddFieldsToTheses < ActiveRecord::Migration[7.0]
  def change
    unless column_exists?(:theses, :title)
      add_column :theses, :title, :string
    end

    unless column_exists?(:theses, :short)
      add_column :theses, :short, :text
    end

    unless column_exists?(:theses, :detail_url)
      add_column :theses, :detail_url, :string
    end
  end
end
