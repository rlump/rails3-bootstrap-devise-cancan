class CreatePredicateRelations < ActiveRecord::Migration
  def change
    create_table :predicate_relations do |t|
      t.string :verb

      t.timestamps
    end
  end
end
