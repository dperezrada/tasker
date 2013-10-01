class TasksController < ApplicationController
	def index
		render json: Task.all
	end
	def create
		task = Task.create
		params['questions'].each do |question|
			Question.create(question: question, task: task)
		end
		render json: []
	end
	def assign
		task = Task.find(params['id'])
		task.users.push(User.find(params['user']))
		render json: []
	end
	def mytasks
		user = User.find_by(authentication_token: params['auth_token'])
		tasks = []
		Task.all.each do |task|
			if task.users.include?(user)
				tasks.push(task)
			end
		end
		render json: tasks
	end
end
