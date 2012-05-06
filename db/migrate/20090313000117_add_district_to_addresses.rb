class AddDistrictToAddresses < ActiveRecord::Migration
  def self.up
    execute "ALTER TABLE `addresses` ADD COLUMN `district` varchar(255) AFTER `city`"
  end

  def self.down
    remove_column :addresses, :district
  end
end
