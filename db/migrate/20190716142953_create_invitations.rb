class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations, id: :uuid do |t|
      t.string :code, null: false
      t.string :email, null: false
      t.uuid :created_by, null: false
      t.datetime :accepted_at
      t.datetime :expires_at, null: false, default: 1.week.from_now
      t.timestamps
    end
  end
end
