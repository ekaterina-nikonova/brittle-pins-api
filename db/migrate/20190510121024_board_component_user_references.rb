# frozen_string_literal: true

# Add references to User in boards and components
class BoardComponentUserReferences < ActiveRecord::Migration[6.0]
  def change
    add_reference :boards, :user, type: :uuid, foreign_key: true
    add_reference :components, :user, type: :uuid, foreign_key: true
  end
end
