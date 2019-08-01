class Movie < ApplicationRecord
  belongs_to :country
  has_and_belongs_to_many :genres

  has_one_attached :image
  
  validates :title, presence: true
  validates :local_title, presence: true 
  validates :year, presence: true,
    numericality: { greater_than_or_equal_to: 1900 }
  validates :text, presence: true
  validates :rate, presence: true, 
    numericality: { less_than_or_equal_to: 10, greater_than_or_equal_to: 0 }

  validates :image, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg']
end
