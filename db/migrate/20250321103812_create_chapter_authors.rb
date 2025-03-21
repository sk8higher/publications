class CreateChapterAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :chapter_authors do |t|
      t.references :chapter, null: false, foreign_key: true
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
