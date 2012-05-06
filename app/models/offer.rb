class Offer < ActiveRecord::Base
  attr :address_attribute
  attr_accessor :serial

  validates_associated :address, :images
  validates_presence_of :category_id, :type_id, :code, :description
  validates_uniqueness_of :code
  validates_format_of     :code, :with => /^[0-9]{4}$/i

  belongs_to :category
  belongs_to :type

  has_one :address, :dependent => :destroy
  has_many :images, :dependent => :destroy
  
  has_many :offers_variables, :class_name => "OffersVariable", :foreign_key => "offer_id", :dependent => :destroy, :order => 'position'
  has_many :variables, :through => :offers_variables

  after_create :attach_images

	named_scope :for_sell, :include => :type, :conditions => { 'types.name' => 'sprzedaż' } 
	named_scope :for_rent, :include => :type, :conditions => { 'types.name' => 'wynajem' } 

	def self.find_active_by_type type
	  find_all_by_status_and_type_id(true, type.id)
	end

  def address_attributes=(attr)
    if address
     address.update_attributes(attr)
    else 
      build_address(attr)
    end
  end

  def offers_variable_attributes=(attributes)
    offers_variables.clear
    offers_variables.build(attributes)
  end

  def apply_variables_from_category 
    (category.parent.variables - variables).each do |var|
      offers_variables.build(:variable => var)
    end
  end

  def url
    cat = ( (category.parent && !['domy', 'działki'].include?(category.name)) ? "-#{category.parent.name}" : "" ) + "-#{category.name}" if category
    street_or_district = "-#{address.street ? address.street : address.district}" if address
    (type.name + cat + street_or_district + "-#{code}").to_url_format 
  end   

	def self.get_from_url uri
	  offer_code = uri.match(/[0-9]{4}$/)[0]	  
		Offer.find_by_code(offer_code)
	end

  protected

  def attach_images
    images << Image.find_all_by_serial(serial)
    images.each(&:reset_serial) 
  end

end
