class MainController < ApplicationController

	def new
		@userinfo = Userinfo.all
	end
end
