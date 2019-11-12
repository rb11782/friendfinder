require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  
  describe "friends#destroy action" do
    it "should allow a user to destroy friends" do
    friend = FactoryBot.create(:friend)
    delete :destroy, params: { id: friend.id }
    expect(response).to redirect_to root_path
    friend = Friend.find_by_id(friend.id)
    expect(friend).to eq nil
    end

    it "should return a 404 message if we cannot find a friend with the id that is specified" do
      delete :destroy, params: { id: 'SPACEDUCK' }
      expect(response).to have_http_status(:not_found)
    end
  end





  describe "friends#update action" do
    
    it "should allow users to successfully update friends" do
      friend = FactoryBot.create(:friend, name: "Jane", address: "21 Saturn")
      patch :update, params: { id: friend.id, friend: { name: 'John', address: "22 Saturn" } }
      expect(response).to redirect_to root_path
      friend.reload
      expect(friend.name).to eq "John"
      expect(friend.address).to eq "22 Saturn"
    end

    it "should have http 404 error if the friend cannot be found" do
      patch :update, params: { id: "YOLOSWAG", friend: { name: 'John', address: "22 Saturn" } }
      expect(response).to have_http_status(:not_found)
    end

    it "should render the edit form with an http status of unprocessable_entity" do
      friend = FactoryBot.create(:friend, name: "Jane", address: "21 Saturn")
      patch :update, params: { id: friend.id, friend: { name: '', address: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      friend.reload
      expect(friend.name).to eq "Jane"
      expect(friend.address).to eq "21 Saturn"
    end
  end


  
  describe "friends#edit action" do
    it "should successfully show the edit form if the friend is found" do
      friend = FactoryBot.create(:friend)
      get :show, params: { id: friend.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error message if the friend is not found" do
      get :show, params: { id: 'SWAG' }
      expect(response).to have_http_status(:not_found)

    end
  end

  describe "friends#show action" do
    it "should successfully show the page if the friend is found" do
      friend = FactoryBot.create(:friend)
      get :show, params: { id: friend.id }
      expect(response).to have_http_status(:success)
    end

    it "should return a 404 error if the friend is not found" do
      get :show, params: { id: 'TACOCAT' }
      expect(response).to have_http_status(:not_found)
    end
  end


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

  

end