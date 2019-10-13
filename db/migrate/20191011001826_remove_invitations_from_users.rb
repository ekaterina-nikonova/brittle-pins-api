# frozen_string_literal: true

# Detach invitations from users
class RemoveInvitationsFromUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :invitations do |t|
      t.remove_index(:user_id)
      t.remove(:user_id)
    end
  end
end
