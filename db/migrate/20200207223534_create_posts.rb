# frozen_string_literal: true

class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.belongs_to :group, :null => false, :foreign_key => true
      t.belongs_to :membership, :null => false, :foreign_key => true
      t.text :body
      t.text :raw_text_body
      t.text :raw_html_body

      t.timestamps
    end
  end
end
