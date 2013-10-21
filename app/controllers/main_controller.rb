class MainController < ApplicationController
	before_filter :authenticate_user!

	def index
		@userinfo = Userinfo.all
	end

	def new
		@newUserinfo = Userinfo.new
		@newUserinfo.name = "test"
		@newUserinfo.number = "hoge"
		@newUserinfo.time = Time.now
		@newUserinfo.save
	end

	def edit
		@editUserinfo = User.find_by id: 2
		# @editUserinfo.name =  update[:name]
		# @editUserinfo.number = update[:number]
		# @editUserinfo.save
	end

	def update
		@updateUserinfo = User.find_by id: 2
		@updateUserinfo.name =  params[:name]
		@updateUserinfo.number = params[:number]
		@updateUserinfo.save
		
	end
end
