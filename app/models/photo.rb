class Photo < ActiveRecord::Base
  attr_accessible :image_url, :page_id
  belongs_to :page
end
