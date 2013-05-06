class CreateSubjectRelations < ActiveRecord::Migration
  def change
    create_table :subject_relations do |t|
      t.string :verb
      t.references :subjectable, polymorphic: true
      t.references :predicable, polymorphic: true

      t.timestamps
    end
  end
end
