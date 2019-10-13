# frozen_string_literal: true

# Add used_at column with timestamp of user's signing up
class AddUsedAtToInvitation < ActiveRecord::Migration[6.0]
  def change
    add_column :invitations, :used_at, :datetime
  end
end
