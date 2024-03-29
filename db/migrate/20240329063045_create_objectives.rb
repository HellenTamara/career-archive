class CreateObjectives < ActiveRecord::Migration[7.1]
  def change
    create_table :objectives do |t|
      t.string :name
      t.boolean :achieved
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
