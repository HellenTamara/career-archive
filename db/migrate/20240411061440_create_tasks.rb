class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.boolean :status
      t.string :name
      t.date :deadline
      t.references :objective, null: false, foreign_key: true

      t.timestamps
    end
  end
end
