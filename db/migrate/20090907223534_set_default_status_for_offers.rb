class SetDefaultStatusForOffers < ActiveRecord::Migration
  def self.up
	  execute('ALTER TABLE `offers` ALTER COLUMN `status` SET DEFAULT 1')
  end

  def self.down
	  execute('ALTER TABLE `offers` ALTER COLUMN `status` DROP DEFAULT')
  end
end
