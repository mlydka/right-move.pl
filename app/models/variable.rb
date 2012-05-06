class Variable < ActiveRecord::Base
  validates_presence_of   :name
  validates_uniqueness_of :name
  validates_format_of     :name,  :with => /^[a-zęółśążźćńĘÓŁŚĄŻŹĆŃ \.\-]+$/i, :message => "can only contain letters, space, dot or dash."

  has_many :categories_variables, :class_name => "CategoriesVariable", :foreign_key => "variable_id"
  has_many :categories, :through => :categories_variables

  has_many :offers_variables, :class_name => "OffersVariable", :foreign_key => "variable_id"
  has_many :offers, :through => :offers_variables

end
