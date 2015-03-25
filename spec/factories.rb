FactoryGirl.define do
	factory :user do
		first_name  "First"
		last_name "Last"
		sequence(:email) { |n| "user#{n}@test.com" }
		password "Test123"
		password_confirmation "Test123"
	end

	factory :title do
		title "I love My Journal"
  		association :user
  	end

  	factory :entry do
  		entry "My New Entry Here"
  		title
  		user
  	end
end