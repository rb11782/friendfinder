require 'rails_helper'

RSpec.describe FriendsController, type: :controller do
  describe "friends#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "friends#new action" do
    it "should successfully show the new form" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end


  describe "friends#create action" do
    it "should successfully create a new friend in our database" do
      post :create, params: { friend: { name: 'John', address: '21 Saturn Court, Sudbury, Ontario P3E 6B8' } }
      expect(response).to redirect_to root_path

      friend = Friend.last
      expect(friend.name).to eq('John')
      expect(friend.address).to eq('21 Saturn Court, Sudbury, Ontario P3E 6B8')
    end
  end

end