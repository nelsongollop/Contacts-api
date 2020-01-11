FactoryBot.define do
  factory :contact do
    first_name { "Bran" }
    last_name { "Stark" }
    phone {"123"}
    sequence :email do |n|
      "#{n}@example.com"
    end
  end
end
