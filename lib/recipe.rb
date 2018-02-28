class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:ingredients)
  validates(:instructions, :presence => true)
  validates(:title, :presence => true)
end
