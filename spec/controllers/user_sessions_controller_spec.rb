require 'rails_helper'

RSpec.describe UserSessionsController, type: :controller do

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe "POST #create" do
    context "with correct credentials" do
      let!(:user) { User.create(first_name: "Jake", last_name: "test", email: "test@test.com", password: "Test123", password_confirmation: "Test123")} 
        it "redirects to the title path" do
          post :create, email: "test@test.com", password: "Test123"
          expect(response).to be_redirect
          expect(response).to redirect_to(titles_path)
        end

        it "finds the user" do
          expect(User).to receive(:find_by).with({email: "test@test.com"}).and_return(user)
          post :create, email: "test@test.com", password: "Test123"
        end


        it "authenticates the user" do
          allow(User).to receive(:find_by).and_return(user)
          expect(user).to receive(:authenticate)
          post :create, email: "test@test.com", password: "Test123"
         end

        it "sets the user_id in the session" do
          post :create, email: "test@test.com", password: "Test123"
          expect(session[:user_id]).to eq(user.id)
        end

        it "sets the flash success message" do
          post :create, email: "test@test.com", password: "Test123"
          expect(flash[:success]).to eq("You have successfully logged in!")
        end        
     end

     shared_examples_for "denied login" do
      it "renders the new template" do
          post :create, email: email, password: password
          expect(response).to render_template('new')
        end

        it "sets flash error message" do
            post :create, email: email, password: password
            expect(flash[:error]).to eq("There was a problem logging in. Please check your email and password.")
        end
      end

     context "with blank credentials" do
        let(:email) { "" }
        let(:password) { "" }
        it_behaves_like "denied login"
      end

    context "with and incorrect password" do
      let!(:user) { User.create(first_name: "Jake", last_name: "test", email: "test@test.com", password: "Test123", password_confirmation: "Test123")} 
        let(:email) { "user.email" }
        let(:password) { "hello" }
        it_behaves_like "denied login"
    end

     context "with no email in existence" do
      let!(:user) { User.create(first_name: "Jake", last_name: "test", email: "test@test.com", password: "Test123", password_confirmation: "Test123")} 
        let(:email) { "none@test.com" }
        let(:password) { "user.password" }
        it_behaves_like "denied login"
      end
  end
end
 

