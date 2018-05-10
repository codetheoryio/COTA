class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :uid, null: false, unique: true
      t.string :title, null: false
      t.text :body
      # t.references :taggable, index: true, polymorphic: true

      t.timestamps null: false
    end
  end
end
