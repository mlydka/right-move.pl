class MoveOptionsFromVariablesToCategoriesVariable < ActiveRecord::Migration
  def self.up
    rename_column :options, :variable_id, :categories_variable_id
  end

  def self.down
    rename_column :options, :categories_variable_id, :variable_id
  end
end
