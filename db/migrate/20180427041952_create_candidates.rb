class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :applied_position
      t.decimal :experience
      t.string :status

      t.timestamps null: false
    end
  end
end
