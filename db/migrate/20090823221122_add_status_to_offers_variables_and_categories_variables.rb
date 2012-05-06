class AddStatusToOffersVariablesAndCategoriesVariables < ActiveRecord::Migration
  def self.up
	  add_column :categories_variables, :status, :boolean
    add_column :offers_variables, :status, :boolean
  end

  def self.down
	  remove_column :categories_variables, :status
	  remove_column :offers_variables, :status
  end
end
