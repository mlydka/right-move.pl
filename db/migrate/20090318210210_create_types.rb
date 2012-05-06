class CreateTypes < ActiveRecord::Migration
  def self.up
    create_table :types, :options => 'default charset=utf8' do |t|
      t.string :name
      t.timestamps
    end

    Type.create({:name => 'sprzedaż'})
    Type.create({:name => 'wynajem'})
  end

  def self.down
    drop_table :types
  end
end
