class Category < ActiveRecord::Base
  acts_as_tree :order => :position

	attr :sell_special_offer_id, :rent_special_offer_id

  validates_presence_of :name
  validates_format_of   :name,  :with => /^[0-9a-zęółśążźćńĘÓŁŚĄŻŹĆŃ \-]+$/i, :message => "can only contain letters."

  has_many :offers
  has_many :categories_variables, :class_name => "CategoriesVariable", :foreign_key => "category_id", :order => :position, :dependent => :destroy
  has_many :variables, :through => :categories_variables

	before_save   :handle_has_special_offer_for_parent
  before_create :clean_positions
  after_destroy :clean_positions

  class << self

    def find_parents
      find(:all, :conditions => ['parent_id IS ?', nil])
    end

		def get_from_url uri
		  find_parents.each do |category|
        if( /#{category.name.to_url_format}/.match(uri) )
          return category
        end
      end

			return nil
		end
			
		def get_from_url_or_default uri
		  get_from_url(uri) || Category.find(:first)
		end			

  end

	def get_special_offer type
	  if is_parent?
		  child = children.find(:first, :include => 'offers', :conditions => ['has_special_offer_for_parent = 1 AND offers.is_special = 1 AND offers.type_id = ? AND offers.status = 1', type.id])
      return child.special_offer(type.name) if child
    else
		  return special_offer type.name			
		end
	end

	def special_offer type_name
	  offers.find(:first, :include => :type, :conditions => [ 'types.name = ? AND is_special = 1 AND status = 1', type_name ])
	end		

	def sell_special_offer_id=(attr)
	  special_offer('sprzedaż').update_attribute(:is_special, nil) if special_offer('sprzedaż')
		offers.for_sell.find_by_id(attr).update_attribute(:is_special, true) if offers.for_sell.find_by_id(attr)
	end

	def rent_special_offer_id=(attr)
    special_offer('wynajem').update_attribute(:is_special, false) if special_offer('wynajem')
		offers.for_rent.find_by_id(attr).update_attribute(:is_special, true) if offers.for_rent.find_by_id(attr)
  end

	def sell_special_offer_id
	  @sell_special_offer_id ||= ( special_offer('sprzedaż').id if special_offer('sprzedaż') )
  end

	def rent_special_offer_id
	  @rent_special_offer_id ||= ( special_offer('wynajem').id if special_offer('wynajem') )
  end

	def active_offers_by_type type
    result = []
    if is_parent?
		  children.each do |child|
        result = result + child.offers.find_active_by_type(type)
			end
    else
      result = offers.find_active_by_type(type)
    end
    result
  end

	def get_url type
	  ( "#{type.name}-" + ( self.parent ? "#{parent.name}-" : "" ) + self.name ).to_url_format
  end

	def get_link_title type
    (get_url type).gsub('-', ' ')
  end

  def get_peripherial type
    return nil unless ['first', 'last'].include?(type)

    order = type == 'first' ? 'ASC' : 'DESC'
    (parent_id.blank? ? self : parent).children.find(:first, :order => "position #{order}")
  end

  def is_first?
    self == get_peripherial('first')
  end
  
  def is_last?
    self == get_peripherial('last')
  end

	def is_parent?
	  !parent_id
	end

  def get_neighbor direction
    return nil if ( parent_id.nil? || !['up', 'down'].include?(direction) )
    operator = direction == 'up' ? '<' : '>'
    order = direction == 'up' ? 'DESC' : 'ASC'
    Category.find(:first, :conditions => "parent_id = #{parent_id} AND position #{operator} #{position}", :order => "position #{order}")
  end

  protected

  def clean_positions
    unless parent_id.blank?
      parent.children.each_with_index do |child, index|
         child.update_attribute(:position, index + 1 )
      end
    end

    self.position = ( parent.children.size + 1 ) if new_record?
  end

	def handle_has_special_offer_for_parent
	  if has_special_offer_for_parent && has_special_offer_for_parent_changed?
		  parent.children.find_all_by_has_special_offer_for_parent(true).each { |sibling| sibling.update_attribute(:has_special_offer_for_parent, false) }
		end
	end
  
end
