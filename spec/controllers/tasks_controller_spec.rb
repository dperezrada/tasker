require 'spec_helper'
require 'ruby-debug'

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
			post :assign, {id: task.id, user: user.email, auth_token: user.authentication_token}
			get :mytasks, auth_token: user.authentication_token
			response.body.should have_json_size(1)
		end
		it "should create an user if it doesn't exist" do
			task = create(:task)
			user = create(:user)
			post :assign, {id: task.id, user: "new_user@test.li", auth_token: user.authentication_token}
			user = User.find_by(email: "new_user@test.li")
			get :mytasks, auth_token: user.authentication_token
			response.body.should have_json_size(1)
		end
		it "should save answers" do
			task = create(:task)
			user = create(:user)
			answers = []
			task.questions.each do |question|
				answers.push({question: question.id, answer: "dunno"})
			end
			post :answer, {id: task.id, user: user.email, auth_token: user.authentication_token, answers: answers}
			get :index, auth_token: user.authentication_token, format: :json
			JSON.parse(response.body).first.should have_key("answers")
		end
	end
end
