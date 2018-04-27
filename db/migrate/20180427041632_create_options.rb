class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :question, index: true, foreign_key: true
      t.text :body
      t.boolean :is_correct

      t.timestamps null: false
    end
  end
end
