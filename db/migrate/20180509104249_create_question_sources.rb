class CreateQuestionSources < ActiveRecord::Migration
  def change
    create_table :question_sources do |t|

      t.string :status, null: false, default: :received

      t.timestamps null: false
    end
  end
end
