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
	end

	def update
		@user.update(editUserinfo_params)
	end

	private
    	# Use callbacks to share common setup or constraints between actions.
    	def set_syusseki
      		@user = User.find(params[:id])
    	end

    	# Never trust parameters from the scary internet, only allow the white list through.
    	def user_params
      		params.require(:user).permit(:name, :number)
    	end
end
