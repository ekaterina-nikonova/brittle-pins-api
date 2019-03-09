class CreateJoinTableBoardComponent < ActiveRecord::Migration[5.2]
  def change
    create_join_table :boards, :components, column_options: { type: :uuid } do |t|
      # t.index [:board_id, :component_id]
      # t.index [:component_id, :board_id]
    end
  end
end
