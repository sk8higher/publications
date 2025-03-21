class CreateChapters < ActiveRecord::Migration[7.1]
  def change
    create_table :chapters do |t|
      t.string :orig_name
      t.string :eng_name
      t.date :publish_date
      t.string :publisher
      t.string :isbn
      t.integer :pages

      t.timestamps
    end
  end
end
