class PopulateContents < ActiveRecord::Migration
  def self.up
	  execute("INSERT INTO `contents` VALUES ('', 'homepage', 'Strona główna',        'Witamy', '', '', '')")
	  execute("INSERT INTO `contents` VALUES ('', 'about',    'O nas',                'O nas', '', '', '')")
	  execute("INSERT INTO `contents` VALUES ('', 'policy',   'Polityka prywatności', 'Polityka prywatności', '', '', '')")
	  execute("INSERT INTO `contents` VALUES ('', 'career',   'Kariera',              'Kariera', '', '', '')")
  end

  def self.down
	   execute("DELETE FROM `contents`")
  end
end
