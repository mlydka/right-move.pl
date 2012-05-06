class AddPositionToOffersVariables < ActiveRecord::Migration
  def self.up
    add_column :offers_variables, :position, :integer, :limit => 4 
  end

  def self.down
    remove_column :offers_variables, :position
  end
end
