class AddLanguageToSection < ActiveRecord::Migration[6.0]
  def change
    add_column :sections, :language, :string
  end
end
