class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :title
      t.text :body
      t.references :taggable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
