FactoryBot.define do
  factory :tool do
    name { 'Foo' }

    trait :with_user do
      after(:create) do |tool|
        tool.users << create(:user)
      end
    end
  end
end
