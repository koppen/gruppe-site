# frozen_string_literal: true

class CreateGroupUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :group_users do |t|
      t.belongs_to :group, :null => false, :foreign_key => true
      t.belongs_to :member, :null => false, :foreign_key => true

      t.timestamps
    end
  end
end
