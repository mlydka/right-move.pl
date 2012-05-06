class Type < ActiveRecord::Base

  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_format_of     :name,  :with => /^[a-zęółśążźćńĘÓŁŚĄŻŹĆŃ ]+$/i, :message => "can only contain letters."

  has_many :offers

	class << self

	  def sell
		  Type.find_by_name('sprzedaż')
		end

		def rent
  	  Type.find_by_name('wynajem')
		end

	end

	def self.get_from_url uri
	  hash = Hash.new
	  Type.find(:all).each do |type|
		  hash.merge!({type.name.to_url_format => type})
		end
		hash[uri[/\w+/]]		
	end

end
