class MainController < ApplicationController
	before_filter :authenticate_user!
	
##基本的にメソッド名と同じviewが対応している

##UserinfoとUserの違い => 出席時間や遅刻判定を持っているのがUserinfo  Deviceが作ったのがUser 両方にnameとnumberがある

	def index
		@userinfo = Userinfo.order("time DESC").limit(10).find_all_by_userId(current_user.id)	
	end

	def index_all
		@userinfoall = Userinfo.order("time DESC").limit(50).find_all_by_userId(current_user.id)	
	end

	def new
		@newUserinfo = Userinfo.new
		#current_userは（多分）Deviceから
		@newUserinfo.name = current_user.name
		@newUserinfo.number = current_user.number
		@newUserinfo.userId = current_user.id
		@newUserinfo.time = Time.now

		##データベースから判定対象の時間設定を持ってくる　今のところactiveで曜日が合っているもののみ
		@timeCheck = TimeConfig.where(["activation = ? and youbi = ? ", 1, @newUserinfo.time.wday]).first
		
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
		@adminUserinfo = Userinfo.order("time DESC").all
	end

	def admin_find
		@adminFind = User.order("number DESC").all
	end

	def admin_result
		@resultUser = User.find_by number: params[:number]
		@userinfoall = Userinfo.order("time DESC").limit(50).find_all_by_userId(@resultUser.id)
	end

	def admin_time_config
		@indexTimeConfig = TimeConfig.order("youbi ,start_hour , start_minitus").all
	end

	def admin_time_config_new
		@newTimeConfig = TimeConfig.new
		@newTimeConfig.youbi = params[:youbi]
		@newTimeConfig.start_hour = params[:s_hour]
		@newTimeConfig.start_minitus = params[:s_minitus]
		@newTimeConfig.end_hour = params[:e_hour]
		@newTimeConfig.end_minitus = params[:e_minitus]
		
		####ex######
		# @newTimeConfig.start_time = params[:start_time]
		# @newTimeConfig.end_time = params[:end_time]
		# $youbi = params[:start_time]
		# @newTimeConfig.youbi = $youbi.weeks
		############

		#初期化
		@newTimeConfig.activation = 0
		@newTimeConfig.save
	end

	def admin_time_config_active_on
		@active_timeconfig = TimeConfig.find_by id: params[:id]
		@active_timeconfig.activation = 1
		@active_timeconfig.save
		redirect_to :back
	end

	def admin_time_config_active_off
		@active_timeconfig = TimeConfig.find_by id: params[:id]
		@active_timeconfig.activation = 0
		@active_timeconfig.save
		redirect_to :back
	end

	def admin_time_config_destroy
		@d_timeconfig = TimeConfig.find_by id: params[:id]
		@d_timeconfig.delete
		# redirect_to :back
	end

end
