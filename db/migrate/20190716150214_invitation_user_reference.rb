# frozen_string_literal: true

# For user.invitations
class InvitationUserReference < ActiveRecord::Migration[6.0]
  def change
    add_reference :invitations, :user, type: :uuid, foreign_key: true
  end
end
