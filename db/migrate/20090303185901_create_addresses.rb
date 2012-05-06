class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses, :options => 'default charset=utf8' do |t|
      t.integer :offer_id
      t.string  :firstname
      t.string  :lastname
      t.string  :city
      t.string  :street
      t.string  :apartment
      t.string  :zip
      t.string  :email
      t.string  :phone
      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
