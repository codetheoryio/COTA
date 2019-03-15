class CreateQuizCandidates < ActiveRecord::Migration
  def change
    create_table :quiz_candidates do |t|
      t.references :quiz, index: true, foreign_key: true
      t.references :candidate, index: true, foreign_key: true
      t.string :status
      t.datetime :assessment_started_at
      t.datetime :assessment_ends_at
      t.string :secure_assessment_token
      t.datetime :secure_token_expire_at
      t.string :secure_assessment_url
      t.text :remarks

      t.timestamps null: false
    end
  end
end
