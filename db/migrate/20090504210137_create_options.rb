class CreateOptions < ActiveRecord::Migration
  def self.up
    create_table :options, :options => 'default charset=utf8' do |t|
      t.integer :variable_id
      t.string :name
    end
  end

  def self.down
    drop_table :options
  end
end
