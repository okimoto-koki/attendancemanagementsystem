class MainController < ApplicationController
	before_filter :authenticate_user!

	def index
		@userinfo = Userinfo.order("time DESC").limit(10).find_all_by_userId(current_user.id)	
	end

	def index_all
		@userinfoall = Userinfo.order("time DESC").limit(50).find_all_by_userId(current_user.id)	
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
		@editUser = User.find_by id: current_user.id
	end

	def update
		@updateUser = User.find_by id: current_user.id
		@updateUser.name =  params[:name]
		@updateUser.number = params[:number]
		@updateUser.save	
	end

	def admin_index
		@adminUserinfo = Userinfo.order("time DESC").all
	end

	def admin_find

	end

	def admin_result
		@resultUser = User.find_by number: params[:number]
		@userinfoall = Userinfo.order("time DESC").limit(50).find_all_by_userId(@resultUser.id)
	end

end
