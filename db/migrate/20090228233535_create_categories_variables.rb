class CreateCategoriesVariables < ActiveRecord::Migration
  def self.up
    create_table :categories_variables, :id => false, :options => 'default charset=utf8' do |t|
      t.integer :category_id
      t.integer :variable_id
    end
  end

  def self.down
    drop_table :categories_variables
  end
end