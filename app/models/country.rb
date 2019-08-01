class Country < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  
  has_many :movies
  
  #capitalize first letter
  def title=(val)
    super(val.capitalize) if val
  end

end
 