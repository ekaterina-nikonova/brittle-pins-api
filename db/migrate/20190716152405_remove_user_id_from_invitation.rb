# frozen_string_literal: true

# Use invitation.user.id instead of created_by
class RemoveUserIdFromInvitation < ActiveRecord::Migration[6.0]
  def change
    change_table :invitations do |t|
      t.remove :created_by
    end
  end
end
