# frozen_string_literal: true

class CreateAuthorReports < ActiveRecord::Migration[7.1]
  def change
    create_table :author_reports do |t|
      t.references :author, null: false, foreign_key: true
      t.references :report, null: false, foreign_key: true

      t.timestamps
    end
  end
end
