class CreateCandidateQuestions < ActiveRecord::Migration
  def change
    create_table :candidate_questions do |t|
      t.references :quiz_candidate, index: true, foreign_key: true
      t.references :question, index: true, foreign_key: true
      t.boolean :answered

      t.timestamps null: false
    end
  end
end
