# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.belongs_to :group, :null => false, :foreign_key => true
      t.belongs_to :membership, :null => false, :foreign_key => true

      t.timestamps
    end
  end
end
