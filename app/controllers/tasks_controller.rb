class TasksController < ApplicationController
	def index
		@tasks = Task.all
	end
	def create
		task = Task.create
		params[:questions].each do |question|
			Question.create(question: question, task: task)
		end
		render json: []
	end
	def assign
		task = Task.find(params[:id])
		unless User.where(email: params[:user]).exists?
			user = User.create(email: params[:user], password: :default_pass)
		end
		user = User.find_by(email: params[:user])
		task.users.push(user)
		render json: []
	end
	def mytasks
		user = User.find_by(authentication_token: params[:auth_token])
		tasks = user.tasks.all
		render json: tasks
	end
	def answer
		user = User.find_by(authentication_token: params[:auth_token])
		task = Task.find(params[:id])
		params[:answers].each do |answer|
			Answer.create(user_id: user.object_id, question_id: answer[:question], answer: answer[:answer], task: task)
		end
		render json: []
	end
end
