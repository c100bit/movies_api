class Genre < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }

  #capitalize first letter
  def title=(val)
    super(val.capitalize) if val
  end

end
