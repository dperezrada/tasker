require 'spec_helper'

describe TasksController do
	render_views

	describe 'GET #index' do
		it "shouldn't be able to access without auth" do
			get :index, format: :json
			response.status.should eq(401)
		end
		it "should return no tasks" do
			user = create(:user)
			get :index, format: :json, auth_token: user.authentication_token
			response.body.should have_json_size(0)
		end
	end

	describe 'POST #index' do
		it "should create a task" do
			user = create(:user)
			post :create, {questions: ['What does the present last?', 'Where did I put the keys?'], auth_token: user.authentication_token}
			get :index, format: :json, auth_token: user.authentication_token
			response.body.should have_json_size(1)
		end
		it "should assign a task" do
			user = create(:user)
			task = create(:task)
			get :mytasks, auth_token: user.authentication_token
			response.body.should have_json_size(0)
			post :assign, {id: task.id, user: user.id, auth_token: user.authentication_token}
			get :mytasks, auth_token: user.authentication_token
			response.body.should have_json_size(1)
		end
	end
end
