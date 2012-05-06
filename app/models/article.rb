class Article < ActiveRecord::Base

  validates_presence_of :title
  validates_presence_of :content
  validates_presence_of :introduction

end
