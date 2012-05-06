class AddSerialToImages < ActiveRecord::Migration
  def self.up
    execute('ALTER TABLE `images` ADD COLUMN `serial` varchar(32) AFTER `height`')
  end

  def self.down
    remove_column :images, :serial
  end
end
