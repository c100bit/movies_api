class MovieSerializer < BaseSerializer
  set_key_transform :dash
  attributes :title, :local_title, :rate, :text, :year, :image_url
  belongs_to :country
  has_many :genres

end