class RemoveSpecialOfferIdFromCategoriesAddIsSpecialFlagToOffer < ActiveRecord::Migration
  def self.up
	  remove_column :categories, :special_offer_id
		execute('ALTER TABLE `offers` ADD COLUMN `is_special` tinyint(1) DEFAULT 0 AFTER `code`')
  end

  def self.down
	  execute('ALTER TABLE `categories` ADD COLUMN `special_offer_id` int(11) AFTER `label`')
		remove_column :offers, :is_special
  end
end
