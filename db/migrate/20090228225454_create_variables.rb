class CreateVariables < ActiveRecord::Migration
  def self.up
    create_table :variables, :options => 'default charset=utf8' do |t|
      t.string :name
      t.timestamps
    end
  end

  def self.down
    drop_table :variables
  end
end
