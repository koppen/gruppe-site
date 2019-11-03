# frozen_string_literal: true

class CreateMemberships < ActiveRecord::Migration[6.0]
  def change
    create_table :memberships do |t|
      t.belongs_to :user, :null => false, :foreign_key => true
      t.string :name

      t.timestamps
    end
  end
end
