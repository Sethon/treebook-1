require 'test_helper'

class UserFriendshipsControllerTest < ActionController::TestCase
  context "#new" do
  	context "when not logged in" do
  		should "redurect to login page" do
  			get :new
  			assert_response :redirect 
  		end
  	end

  	context "when logged in" do
  		setup do
  			sign_in users(:jeff)
  		end
  		should "get new and return success" do
  			get :new
  			assert_response :success
  		end
  		should "should set flash error if friend_id is not set" do
  			get :new, {}
  			assert_equal "Friend required", flash[:error]
  		end
  		should "display the friends name" do
  			get :new, :friend_id => users(:jeff).id
  			assert_match /#{users(:jeff).full_name}/, response.body
  		end
  		should "assign a new user friendship" do
  			get :new, :friend_id => users(:jeff).id
  			assert assigns(:user_friendship)
  		end
  	end
  end
end
