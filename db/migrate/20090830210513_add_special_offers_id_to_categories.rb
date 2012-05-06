class AddSpecialOffersIdToCategories < ActiveRecord::Migration
  def self.up
	  execute('ALTER TABLE `categories` ADD COLUMN `special_offer_id` int(11) AFTER `label`')
  end

  def self.down
	  remove_column :categories, :special_offer_id
  end
end
