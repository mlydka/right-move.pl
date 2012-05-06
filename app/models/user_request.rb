class UserRequest
  include Validatable
 
  attr_accessor :type, :category, :firstname, :lastname, :phone, :email, :city, :district, :street,
                       :price_from, :price_to, :price2_from, :price2_to, :area_from, :area_to

  validates_presence_of :type, :category, :firstname, :phone, :city, :district

  validates_format_of   :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i, :if => Proc.new {|e| !e.blank?}
end
