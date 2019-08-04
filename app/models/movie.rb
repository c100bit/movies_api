class Movie < ApplicationRecord
  include Rails.application.routes.url_helpers

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
  validates :image, attached: true, 
    content_type: ['image/png', 'image/jpg', 'image/jpeg']

  scope :filter_by, -> (field, val) { where("#{field}": val).order(field) }

  scope :filter_by_title, -> (val) { where("lower(title) = ?", val.downcase) }

  scope :filter_by_genres, -> (ids) do
    joins(:genres)
    .where(genres: { id: ids })
    .having("COUNT(DISTINCT genres.id) = #{ids.count}")
    .group('id').order(:id).distinct
  end

  def image_url
     rails_blob_path(image, only_path: true)
  end

end
