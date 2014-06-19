class AddImageColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :image_location, :string
  end
end
