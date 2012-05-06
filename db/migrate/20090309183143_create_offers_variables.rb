class CreateOffersVariables < ActiveRecord::Migration
  def self.up
    create_table :offers_variables, :options => 'default charset=utf8' do |t|
      t.integer :offer_id
      t.integer :variable_id
      t.string  :value
    end
  end

  def self.down
    drop_table :offers_variables
  end
end
