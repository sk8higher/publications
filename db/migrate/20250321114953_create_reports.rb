# frozen_string_literal: true

class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.string :orig_name
      t.string :eng_name
      t.date :publish_date
      t.string :conference_name
      t.string :conference_location
      t.references :speaker, foreign_key: { to_table: :authors }

      t.timestamps
    end
  end
end
