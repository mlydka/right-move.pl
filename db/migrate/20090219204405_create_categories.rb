class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories, :options => 'default charset=utf8' do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
