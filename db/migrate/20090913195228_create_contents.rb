class CreateContents < ActiveRecord::Migration
  def self.up
	  create_table :contents, :options => 'default charset=utf8' do |t|
			t.string :type,  :limit => 64
			t.string :name,  :limit => 64
			t.string :label, :limit => 64
			t.text   :text
      t.timestamps
    end
  end

  def self.down
	  drop_table :contents
  end
end
