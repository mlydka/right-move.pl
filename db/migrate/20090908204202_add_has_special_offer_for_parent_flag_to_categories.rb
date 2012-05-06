class AddHasSpecialOfferForParentFlagToCategories < ActiveRecord::Migration
  def self.up
	  execute('ALTER TABLE `categories` ADD COLUMN `has_special_offer_for_parent` tinyint(1) DEFAULT 0 AFTER `label`')
  end

  def self.down
	  remove_column :categories, :has_special_offer_for_parent
  end
end
