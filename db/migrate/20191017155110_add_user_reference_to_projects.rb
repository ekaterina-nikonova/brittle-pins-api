# frozen_string_literal: true

# Add reference to User in projects
class AddUserReferenceToProjects < ActiveRecord::Migration[6.0]
  def change
    add_reference :projects, :user, type: :uuid, foreign_key: true
  end
end
