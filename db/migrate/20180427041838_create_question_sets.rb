class CreateQuestionSets < ActiveRecord::Migration
  def change
    create_table :question_sets do |t|
      t.references :quiz, index: true, foreign_key: true
      t.integer :question_count
      t.references :taggable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
