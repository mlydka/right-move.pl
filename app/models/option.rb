class Option < ActiveRecord::Base

  validates_presence_of :name

  belongs_to :categories_variable

end
