class CreateJournals < ActiveRecord::Migration[7.1]
  def change
    create_table :journals do |t|
      t.string :name
      t.string :issn

      t.timestamps
    end
  end
end
