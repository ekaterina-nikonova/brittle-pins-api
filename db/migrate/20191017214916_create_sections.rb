class CreateSections < ActiveRecord::Migration[6.0]
  def change
    create_table :sections, id: :uuid do |t|
      t.text :paragraph, null: false
      t.text :code

      t.timestamps
    end
  end
end
