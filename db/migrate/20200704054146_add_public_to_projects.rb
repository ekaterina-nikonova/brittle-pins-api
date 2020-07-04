# frozen_string_literal: true

# 'Public' attribute allows to see the project without logging in

class AddPublicToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :public, :boolean
  end
end
