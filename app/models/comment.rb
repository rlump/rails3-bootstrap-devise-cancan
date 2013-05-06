class Comment < ActiveRecord::Base
  attr_accessible :description, :name

  has_many :subject_relations, :as => :subjectable
  has_many :predicates, :as => :predicable, class_name: "SubjectRelation", foreign_key: "predicable_id"


  has_many :predicate_relations, :as => :predicable

end
