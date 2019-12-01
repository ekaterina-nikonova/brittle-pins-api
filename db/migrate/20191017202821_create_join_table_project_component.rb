class CreateJoinTableProjectComponent < ActiveRecord::Migration[6.0]
  def change
    create_join_table :projects, :components, column_options: { type: :uuid }
  end
end
