class AddPositionToVariables < ActiveRecord::Migration
  def self.up
    add_column :variables, :position, :integer
  end

  def self.down
    remove_column :variables, :position
  end
end
