class UserOffer
  include Validatable
 
  attr_accessor :type, :category, :firstname, :lastname, :phone, :email, :city, :district, :street, :price, :area

  validates_presence_of :type, :category, :firstname, :phone, :city, :street

  validates_format_of   :email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+.[A-Z]{2,4}$/i, :if => Proc.new {|e| !e.blank?}
end