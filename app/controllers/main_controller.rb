class MainController < ApplicationController
	before_filter :authenticate_user!
	
##基本的にメソッド名と同じviewが対応している

##UserinfoとUserの違い => 出席時間や遅刻判定を持っているのがUserinfo  Deviceが作ったのがUser 両方にnameとnumberがある

	def index
		@userinfo = Userinfo.order("time DESC").limit(10).find_all_by_userId(current_user.id)
	end

	def index_all
		@userinfoall = Kaminari.paginate_array(Userinfo.order("time DESC").find_all_by_userId(current_user.id)).page(params[:page]).per(15)
	end

	def new
		@newUserinfo = Userinfo.new
		#current_userは（多分）Deviceから
		@newUserinfo.name = current_user.name
		@newUserinfo.number = current_user.number
		@newUserinfo.userId = current_user.id
		@newUserinfo.time = Time.now

		##データベースから判定対象の時間設定を持ってくる
		@timeCheck = TimeConfig.where([
			"activation = ? 
			and youbi = ? 
			and start_hour <= ? 
			and start_minitus <= ? 
			and end_hour >= ? ",
			1, 
			@newUserinfo.time.wday, 
			@newUserinfo.time.hour, 
			@newUserinfo.time.min, 
			@newUserinfo.time.hour, 
			]).first
		
		#######refリファクタリング予定地#########
		#データベースから値を取ってこれなかった時用の例外処理
		begin
			#####遅刻判定部分true(1)で出席#####
			#登録した時間のhourがstart_hour以上　かつ　end_hour以下　かつ　minitusがstart_minitus以上
			if @newUserinfo.time.hour >= @timeCheck.start_hour && @newUserinfo.time.min >= @timeCheck.start_minitus && @newUserinfo.time.hour <= @timeCheck.end_hour then
				#登録した時間のhourがend_hour以下　もしくは (end_hourと同じ　かつ　minitusがend_minitus以下) 
				if @newUserinfo.time.hour < @timeCheck.end_hour || (@newUserinfo.time.hour == @timeCheck.end_hour && @newUserinfo.time.min < @timeCheck.end_minitus) then
					@newUserinfo.check = true
				else 
					@newUserinfo.check = false
				end
			else
				@newUserinfo.check = false
			end
		#データベースに値が無い場合、遅刻判定にnil(何もなし)を入れる
		rescue
			@newUserinfo.check = nil
		end
		###############################

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

	def destroy
		@d_userinfo = Userinfo.find_by id: params[:id]
		@d_userinfo.delete
		redirect_to :back
	end

	########以下管理者用########

	def admin_index
		@adminUserinfo = Kaminari.paginate_array(Userinfo.order("time DESC").all).page(params[:page]).per(10)
	end

	def admin_find
		@adminFind = Kaminari.paginate_array(User.order("number DESC").all).page(params[:page]).per(10)
	end

	def admin_result
		@resultUser = User.find_by number: params[:number]
		@userinfoall = Kaminari.paginate_array(Userinfo.order("time DESC").limit(50).find_all_by_userId(@resultUser.id)).page(params[:page]).per(10)

		# ###now####
		# $count = Userinfo.where(["number = ? and check = ?",@resultUser.id, 0]).count
		# ##########

	end

	def admin_time_config
		@indexTimeConfig = TimeConfig.order("youbi ,start_hour , start_minitus").all
	end

	def admin_time_config_new
		@newTimeConfig = TimeConfig.new
		@newTimeConfig.youbi = params[:youbi]
		
		####refリファクタリング予定地####
		#コマで時間設定
		case params[:koma] 
		when "1" then
			@newTimeConfig.start_hour = 9
    			@newTimeConfig.start_minitus = 0
    			@newTimeConfig.end_hour = 10
   			@newTimeConfig.end_minitus = 30
   		when "2" then
   			@newTimeConfig.start_hour = 10
    			@newTimeConfig.start_minitus = 45
    			@newTimeConfig.end_hour = 12
   			@newTimeConfig.end_minitus = 15
   		when "3" then
   			@newTimeConfig.start_hour = 13
    			@newTimeConfig.start_minitus = 15
    			@newTimeConfig.end_hour = 14
   			@newTimeConfig.end_minitus = 45
   		when "4" then
   			@newTimeConfig.start_hour = 15
    			@newTimeConfig.start_minitus = 0
    			@newTimeConfig.end_hour = 16
   			@newTimeConfig.end_minitus = 30
   		when "5" then
   			@newTimeConfig.start_hour = 16
    			@newTimeConfig.start_minitus = 45
    			@newTimeConfig.end_hour = 18
   			@newTimeConfig.end_minitus = 15
   		when "6" then
   			@newTimeConfig.start_hour = 18
    			@newTimeConfig.start_minitus = 30
    			@newTimeConfig.end_hour = 20
   			@newTimeConfig.end_minitus = 0
   		end
   		##########################
		

		#初期化
		@newTimeConfig.activation = 0
		@newTimeConfig.save
	end

	##時間設定の有効化##
	def admin_time_config_active_on
		@active_timeconfig = TimeConfig.find_by id: params[:id]
		@active_timeconfig.activation = 1
		@active_timeconfig.save
		redirect_to :back
	end

	##時間設定の無効化##
	def admin_time_config_active_off
		@active_timeconfig = TimeConfig.find_by id: params[:id]
		@active_timeconfig.activation = 0
		@active_timeconfig.save
		redirect_to :back
	end

	def admin_time_config_destroy
		@d_timeconfig = TimeConfig.find_by id: params[:id]
		@d_timeconfig.delete
		redirect_to :back
	end

end
