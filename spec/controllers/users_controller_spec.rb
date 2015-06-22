# require 'rails_helper'

# RSpec.describe UsersController, type: :controller do

# 	let(:valid_attributes) {
# 		{
# 		first_name: "Jake",
# 		last_name: "test",
# 		email: "test@test.com",
# 		password: "password",
# 		password_confirmation: "password"
# 		}
# 	}
	
# 	let(:valid_session) { {} }

# 	describe "user session" do
# 		it "sets the session user_id to the created user" do

#         post :create, {:user => valid_attributes}, valid_session
#         expect(session[:user_id]).to eq(User.find_by(email: valid_attributes[:email]).id)
# 		end
# 	end
# end
