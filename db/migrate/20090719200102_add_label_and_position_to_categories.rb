class AddLabelAndPositionToCategories < ActiveRecord::Migration
  def self.up
    execute("ALTER TABLE `categories` ADD COLUMN `position` integer(4) AFTER `parent_id`")
    execute("ALTER TABLE `categories` ADD COLUMN `label` varchar(128) AFTER `position`")
  end

  def self.down
    remove_column :categories, :label
    remove_column :categories, :position
  end
end
