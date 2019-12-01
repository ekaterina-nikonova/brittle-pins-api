class CreateChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :chapters, id: :uuid do |t|
      t.string :name, null: false
      t.text :intro

      t.timestamps
    end
  end
end
