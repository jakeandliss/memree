require 'rails_helper'

RSpec.describe TitlesController do

let(:valid_attributes) { { "title" => "MyString" } }
let(:valid_session) { {} }
let!(:user) { create(:user) }

before do
 sign_in(user)
end
  
  describe "GET index" do
    context "logged in" do
      it "assigns all titles as @titles" do
        title = user.titles.create! valid_attributes
        get :index, {}, valid_session
        (:titles).should eq([title])
        expect(assigns(:titles).map(&:user)).to eq([user])
      end

      it "does not load other user's titles" do
        other_title = user.titles.create!(valid_attributes.merge(user_id: create(:user).id))
        get :index, {}, valid_session
        expect(assigns(:titles)).to_not include(other_title)
      end
    end
  end

  describe "GET show" do
    it "assigns the requested title as @title for the logged in user" do
      title = user.titles.create! valid_attributes
      get :show, {:id => title.to_param}, valid_session
      assigns(:title).should eq(title)
      expect(assigns(:title).user).to eq(user)
    end
  end

  describe "GET new" do
    it "assigns a new title as @title for the logged in user" do
      get :new, {}, valid_session
      assigns(:title).should be_a_new(user.titles)
      expect(assigns(:title).user).to eq(user)
    end
  end

  describe "GET edit" do
    it "assigns the requested title as @title" do
      title = user.titles.create! valid_attributes
      get :edit, {:id => title.to_param}, valid_session
      assigns(:title).should eq(title)
      expect(assigns(:title).user).to eq(user)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new user.titles" do
        expect {
          post :create, {:title => valid_attributes}, valid_session
        }.to change(user.titles, :count).by(1)
      end

      it "assigns a newly created title as @title" do
        post :create, {:title => valid_attributes}, valid_session
        expect(:title).to be_a(user.title)
        assigns(:title).should be_persisted
      end

      it "redirects to the created title" do
        post :create, {:title => valid_attributes}, valid_session
        response.should redirect_to(user.titles.last)
      end

      it "creates a title for the current user" do
        post :create, {:title => valid_attributes}, valid_session
        title = user.titles.last
        expect(title.user).to eq(user)
      end

      it "does not allow users to create titles for other users" do
        other_user = create(:user)
        post :create, {:title => valid_attributes.merge(user_id: other_user.id)}, valid_session
        title = user.titles.last
        expect(title.user).to eq(user)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved title as @title" do
        # Trigger the behavior that occurs when invalid params are submitted
        user.titles.any_instance.stub(:save).and_return(false)
        post :create, {:title => { "title" => "invalid value" }}, valid_session
        assigns(:title).should be_a_new(user.titles)
        expect(assigns(:title).user).to eq(user)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        user.titles.any_instance.stub(:save).and_return(false)
        post :create, {:title => { "title" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested title" do
        title = user.titles.create! valid_attributes
        # Assuming there are no other titles in the database, this
        # specifies that the user.titles created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        user.titles.any_instance.should_receive(:update).with({ "title" => "MyString" })
        put :update, {:id => title.to_param, :title => { "title" => "MyString" }}, valid_session
      end

      it "assigns the requested title as @title" do
        title = user.titles.create! valid_attributes
        put :update, {:id => title.to_param, :title => valid_attributes}, valid_session
        assigns(:title).should eq(title)
        expect(assigns(:title).user).to eq(user)
      end

      it "redirects to the title" do
        title = user.titles.create! valid_attributes
        put :update, {:id => title.to_param, :title => valid_attributes}, valid_session
        response.should redirect_to(title)
      end
    end

    describe "with invalid params" do
      it "assigns the title as @title" do
        title = user.titles.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        user.titles.any_instance.stub(:save).and_return(false)
        put :update, {:id => title.to_param, :title => { "title" => "invalid value" }}, valid_session
        assigns(:title).should eq(title)
      end

      it "re-renders the 'edit' template" do
        title = user.titles.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        user.titles.any_instance.stub(:save).and_return(false)
        put :update, {:id => title.to_param, :title => { "title" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested title" do
      title = user.titles.create! valid_attributes
      expect {
        delete :destroy, {:id => title.to_param}, valid_session
      }.to change(user.titles, :count).by(-1)
    end

    it "redirects to the titles list" do
      title = user.titles.create! valid_attributes
      delete :destroy, {:id => title.to_param}, valid_session
      response.should redirect_to(titles_url)
    end
  end

end
