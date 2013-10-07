class MainController < ApplicationController

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
end
