class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :offer_id
      t.integer :parent_id
      t.string  :content_type
      t.string  :filename
      t.string  :thumbnail
      t.integer :size
      t.integer :width
      t.integer :height
      t.timestamps
    end
  end

  def self.down
    drop_table :images
  end
end
