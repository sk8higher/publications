# frozen_string_literal: true

class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :fullname
      t.string :orcid

      t.timestamps
    end
  end
end
