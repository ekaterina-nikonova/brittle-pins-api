# frozen_string_literal: true

# Expiration date will be set in controller
class ChangeDefaultInInvitations < ActiveRecord::Migration[6.0]
  def change
    change_table :invitations do |t|
      t.change_default(:expires_at, nil)
    end
  end
end
