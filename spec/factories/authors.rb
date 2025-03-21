FactoryBot.define do
  factory :author do
    fullname { 'Иван Иванов' }
    sequence(:orcid) do |n|
      "0000-0001-#{format('%04d', n)}-#{rand(1000..9999).to_s.last(4)}"
    end
  end
end
