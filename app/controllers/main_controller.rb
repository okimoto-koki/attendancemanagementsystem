class MainController < ApplicationController
	before_filter :authenticate_user!

	def index
		@userinfo = Userinfo.order("time DESC").limit(10).find_all_by_userId(current_user.id)
		
	end

	def new
		@newUserinfo = Userinfo.new
		@newUserinfo.name = current_user.name
		@newUserinfo.number = current_user.number
		@newUserinfo.userId = current_user.id
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
