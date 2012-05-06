class CategoriesVariable < ActiveRecord::Base

  belongs_to :category
  belongs_to :variable

  validates_associated :options
  
  after_update :save_options, :propagate_values
  after_destroy :destroy_variable
  
  has_many :options, :dependent => :destroy, :order => 'id'

  def initialize params = {}
    super
    self.status = false unless status
  end

  def new_option_attributes=(attributes)
    attributes.each do |attr|
      options.build(attr)
    end
  end

  def existing_option_attributes=(attributes)
    options.reject(&:new_record?).each do |option|
      if attr = attributes[option.id.to_s]
        option.attributes = attr
      else
        options.delete(option)
      end
    end
  end

  protected

  def save_options
    options.each do |option|
      option.save(false)
    end
  end

  def propagate_values
    category.children.each do |subcategory|
      subcategory.offers.each do |offer|
        offer.offers_variables.find_all_by_variable_id(variable_id).each do |offers_variable|
				  offers_variable.update_attributes({:position => position, :status => status})
				end
      end
    end
  end

  def destroy_variable
    if variable.categories.length == 0
      variable.destroy
    end
  end

end
