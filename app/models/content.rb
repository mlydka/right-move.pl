class Content < ActiveRecord::Base
  validates_presence_of :label
  validates_presence_of :text

  # Disable single table inheritence
  set_inheritance_column 'not_used_here'
end
