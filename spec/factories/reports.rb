FactoryBot.define do
  factory :report do
    orig_name { 'Доклад на конференции' }
    eng_name { 'Conference Report' }
    publish_date { Date.today }
    conference_name { 'Международный симпозиум' }
    conference_location { 'заграничная' }
    association :speaker, factory: :author
    authors { [speaker] }
  end
end
