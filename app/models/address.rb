class Address < ActiveRecord::Base

  validates_format_of   :city,      :with => /^[a-zęółśążźćńĘÓŁŚĄŻŹĆŃ]+[\- ]*[a-zęółśążźćńĘÓŁŚĄŻŹĆŃ]+$/i, :message => "can only contain letters, space or dash.",
                                    :unless => Proc.new {|a| a.city.blank?}

  validates_format_of   :district,  :with => /^[a-zęółśążźćńĘÓŁŚĄŻŹĆŃ]+[\- ]*[a-zęółśążźćńĘÓŁŚĄŻŹĆŃ]+$/i, :message => "can only contain letters, space or dash.",
                                    :unless => Proc.new {|a| a.district.blank?}
  validates_presence_of :street
  validates_format_of   :street,    :with => /^([0-9a-zęółśążźćńĘÓŁŚĄŻŹĆŃ]+[\-\. ]*)+[0-9a-zęółśążźćńĘÓŁŚĄŻŹĆŃ]+$/i, :message => "can only contain letters, numbers, space, dot or dash."

  validates_presence_of :apartment
  validates_format_of   :apartment, :with => /^[0-9a-z\/ ]+$/i, :message => "should have correct format."

  belongs_to :offer

	def self.get_cracov_districts
	  ['Bronowice', 'Cichy kącik', 'Grzegórzki', 'Łobzów', 'Olsza', 'Prądnik biały', 'Stare Miasto', 'Wola justowska']
	end

end
