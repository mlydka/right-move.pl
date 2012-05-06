class AddCodeToOffers < ActiveRecord::Migration
  def self.up
    execute('ALTER TABLE `offers` ADD COLUMN `code` varchar(4) AFTER `status`')
  end

  def self.down
    remove_column :offers, :code
  end
end
