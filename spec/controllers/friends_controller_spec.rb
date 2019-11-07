require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  describe "friends#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "friends#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end



    it "should successfully show the new form" do
      user = FactoryBot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end
  end


  describe "friends#create action" do
    
    it "should require users to be logged in" do
      post :create, params: { friend: { name: 'John', address: '21 Saturn Court, Sudbury, Ontario P3E 6B8' } }
      expect(response).to redirect_to new_user_session_path
    end


    it "should successfully create a new friend in our database" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: { friend: { name: 'John', address: '21 Saturn Court, Sudbury, Ontario P3E 6B8' } }
      expect(response).to redirect_to root_path

      friend = Friend.last
      expect(friend.name).to eq('John')
      expect(friend.address).to eq('21 Saturn Court, Sudbury, Ontario P3E 6B8')
      expect(friend.user).to eq(user)
    end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      friend_count = Friend.count
      post :create, params: { friend: { name: '', address: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(friend_count).to eq Friend.count
    end

  end

  describe "friends#edit action" do
    it "should successfully show the edit form if the friend is found" do

    end

    it "should return a 404 error message if the friend is not found" do

    end
  end

end