class CreateQuizCandidates < ActiveRecord::Migration
  def change
    create_table :quiz_candidates do |t|
      t.references :quiz, index: true, foreign_key: true
      t.references :candidate, index: true, foreign_key: true
      t.string :status
      t.text :remarks

      t.timestamps null: false
    end
  end
end
