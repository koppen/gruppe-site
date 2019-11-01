# frozen_string_literal: true

class CreateInvitations < ActiveRecord::Migration[6.0]
  def change
    create_table :invitations do |t|
      t.string :email
      t.references :group, :null => false, :foreign_key => true
      t.string :token
      t.references :user, :null => false, :foreign_key => true

      t.timestamps
    end
    add_index :invitations, :token, :unique => true
  end
end
