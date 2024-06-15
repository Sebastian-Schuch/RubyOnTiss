class AddFieldsToPersons < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :firstname, :string
    add_column :people, :lastname, :string
    add_column :people, :gender, :string
    add_column :people, :prefix_title, :string
    add_column :people, :postfix_title, :string
    add_column :people, :adressbuch_benutzerbild, :string
    add_column :people, :adressbuch_visitenkarte, :string
  end
end
