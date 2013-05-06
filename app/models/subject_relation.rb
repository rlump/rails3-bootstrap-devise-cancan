class SubjectRelation < ActiveRecord::Base
  attr_accessible :verb
  belongs_to :subjectable, polymorphic: true
  belongs_to :predicable, polymorphic: true
end
