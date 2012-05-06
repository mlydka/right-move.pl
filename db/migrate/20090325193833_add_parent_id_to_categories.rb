class AddParentIdToCategories < ActiveRecord::Migration
  def self.up
    execute('ALTER TABLE `categories` ADD COLUMN `parent_id` integer AFTER `name`')
  end

  def self.down
    remove_column :categories, :parent_id
  end
end
