class MainController < ApplicationController
	before_filter :authenticate_user!

	def index
		@userinfo = Userinfo.all
	end

	def new
		@newUserinfo = Userinfo.new
		@newUserinfo.name = current_user.name
		@newUserinfo.number = current_user.number
		@newUserinfo.time = Time.now
		@newUserinfo.save
	end

	def edit
		@editUserinfo = User.find_by id: current_user.id
	end

	def update
		@updateUserinfo = User.find_by id: current_user.id
		@updateUserinfo.name =  params[:name]
		@updateUserinfo.number = params[:number]
		@updateUserinfo.save
		
	end
end
