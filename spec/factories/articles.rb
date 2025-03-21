FactoryBot.define do
  factory :article do
    orig_name { 'Название статьи' }
    eng_name { 'Article Title' }
    publish_date { Date.today }
    doi { '10.1234/5678' }
    journal
    authors { [association(:author)] }
  end
end
