class Recipe < ActiveRecord::Base
  has_and_belongs_to_many(:ingredients)
  has_and_belongs_to_many(:tags)
  validates(:title, {:presence => true})
  validates(:instructions, {:presence => true})
  before_save(:titlecase_title)


private

  def titlecase_title
    self.title=(title().titlecase())
  end
end
