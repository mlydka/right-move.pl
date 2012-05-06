class OffersVariable < ActiveRecord::Base

  belongs_to :offer
  belongs_to :variable

  def after_create
	  categories_variable = offer.category.parent.categories_variables.find_by_variable_id(variable.id)
    self.update_attributes({:position => categories_variable.position, :status => categories_variable.status})
  end

end
