class Page < ActiveRecord::Base
  attr_accessible :project_id
  belongs_to :user
  has_many :photos
end
