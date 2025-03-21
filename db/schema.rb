# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_250_321_115_209) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'article_authors', force: :cascade do |t|
    t.bigint 'article_id', null: false
    t.bigint 'author_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['article_id'], name: 'index_article_authors_on_article_id'
    t.index ['author_id'], name: 'index_article_authors_on_author_id'
  end

  create_table 'articles', force: :cascade do |t|
    t.string 'orig_name'
    t.string 'eng_name'
    t.date 'publish_date'
    t.string 'doi'
    t.bigint 'journal_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['journal_id'], name: 'index_articles_on_journal_id'
  end

  create_table 'author_reports', force: :cascade do |t|
    t.bigint 'author_id', null: false
    t.bigint 'report_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['author_id'], name: 'index_author_reports_on_author_id'
    t.index ['report_id'], name: 'index_author_reports_on_report_id'
  end

  create_table 'authors', force: :cascade do |t|
    t.string 'fullname'
    t.string 'orcid'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'chapter_authors', force: :cascade do |t|
    t.bigint 'chapter_id', null: false
    t.bigint 'author_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['author_id'], name: 'index_chapter_authors_on_author_id'
    t.index ['chapter_id'], name: 'index_chapter_authors_on_chapter_id'
  end

  create_table 'chapters', force: :cascade do |t|
    t.string 'orig_name'
    t.string 'eng_name'
    t.date 'publish_date'
    t.string 'publisher'
    t.string 'isbn'
    t.integer 'pages'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'journals', force: :cascade do |t|
    t.string 'name'
    t.string 'issn'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'reports', force: :cascade do |t|
    t.string 'orig_name'
    t.string 'eng_name'
    t.date 'publish_date'
    t.string 'conference_name'
    t.string 'conference_location'
    t.bigint 'speaker_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['speaker_id'], name: 'index_reports_on_speaker_id'
  end

  add_foreign_key 'article_authors', 'articles'
  add_foreign_key 'article_authors', 'authors'
  add_foreign_key 'articles', 'journals'
  add_foreign_key 'author_reports', 'authors'
  add_foreign_key 'author_reports', 'reports'
  add_foreign_key 'chapter_authors', 'authors'
  add_foreign_key 'chapter_authors', 'chapters'
  add_foreign_key 'reports', 'authors', column: 'speaker_id'
end
