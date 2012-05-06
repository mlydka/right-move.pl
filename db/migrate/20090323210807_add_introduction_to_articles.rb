class AddIntroductionToArticles < ActiveRecord::Migration
  def self.up
    execute('ALTER TABLE `articles` ADD COLUMN `introduction` text AFTER `title`')
  end

  def self.down
    remove_column :articles, :introduction
  end
end
