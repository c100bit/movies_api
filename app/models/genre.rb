class Genre < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  has_and_belongs_to_many :movies

  #capitalize first letter
  def title=(val)
    super(val.capitalize) if val
  end

end 
