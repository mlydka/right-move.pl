class AddTypeIdToOffers < ActiveRecord::Migration
  def self.up
    execute("ALTER TABLE `offers` ADD COLUMN `type_id` integer AFTER `category_id`")
  end

  def self.down
    remove_colum :offers, :type_id
  end
end
