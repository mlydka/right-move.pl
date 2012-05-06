class MovingPositionFromVariablesToCategoriesVariables < ActiveRecord::Migration
  def self.up
    remove_column :variables, :position
    execute("ALTER TABLE `categories_variables` ADD COLUMN `id` INT(11) NOT NULL AUTO_INCREMENT FIRST, ADD PRIMARY KEY (`id`)")
    add_column :categories_variables, :position, :integer, :limit => 4
  end

  def self.down
    remove_column :categories_variables, :position
    remove_column :categories_variables, :id
    add_column :variables, :position, :integer
  end
end
