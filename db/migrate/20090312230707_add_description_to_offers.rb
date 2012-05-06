class AddDescriptionToOffers < ActiveRecord::Migration
  def self.up
    add_column :offers, :description, :text
  end

  def self.down
    remove_column :offers, :description
  end
end
