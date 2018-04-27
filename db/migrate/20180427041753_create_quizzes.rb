class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :name
      t.string :job_title
      t.text :introduction
      t.text :rules
      t.integer :time_limit

      t.timestamps null: false
    end
  end
end
