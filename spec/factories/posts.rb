FactoryGirl.define do
  factory :post do
    title "New post"
    body "Text of the new post"
    user
  end
end
