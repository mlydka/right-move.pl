class DeleteFieldsFromAddresses < ActiveRecord::Migration
  def self.up
    remove_column :addresses, :firstname
    remove_column :addresses, :lastname
    remove_column :addresses, :zip
    remove_column :addresses, :email
    remove_column :addresses, :phone
  end

  def self.down
    add_column :addresses, :firstname, :string
    add_column :addresses, :lastname, :string
    add_column :addresses, :zip, :string
    add_column :addresses, :email, :string
    add_column :addresses, :phone, :string
  end
end
