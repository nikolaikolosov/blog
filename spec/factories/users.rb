FactoryGirl.define do
  factory :role do
    name 'admin'
  end

  factory :user do
    name 'Name'
    email 'test@test.ru'
    password 'testtesttest'
    password_confirmation { password }

    factory :user_with_one_post do
      after(:create) do |user|
        create(:post, user: user)
      end
    end

    factory :user_with_admin_role do
      roles {[FactoryGirl.create(:role)]}
    end
  end
end