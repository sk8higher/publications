# frozen_string_literal: true

class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :orig_name
      t.string :eng_name
      t.date :publish_date
      t.string :doi
      t.belongs_to :journal, null: false, foreign_key: true

      t.timestamps
    end
  end
end
