class AddColumnToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :userid, :integer
  end
end
