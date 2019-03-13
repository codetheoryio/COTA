class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :candidate_question, index: true, foreign_key: true
      # t.references :question
      t.references :option, index: true, foreign_key: true
      t.text :answer_body
      t.text :remarks

      t.timestamps null: false
    end
  end
end
