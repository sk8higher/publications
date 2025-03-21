FactoryBot.define do
  factory :chapter do
    orig_name { 'Название главы' }
    eng_name { 'Chapter Title' }
    publish_date { Date.today }
    publisher { 'Издательство' }
    isbn { '978-3-16-148410-0' }
    pages { 100 }
    authors { [association(:author)] }
  end
end
