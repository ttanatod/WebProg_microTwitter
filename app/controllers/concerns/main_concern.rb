module MainConcern
	extend ActiveSupport::Concern

	included do 
		helper_method :is_logged_in
	end

	def is_logged_in
		if !session[:user_id]
			respond_to do |format|
				format.html {redirect_to main_url, flash:{alert: "Please login!"}}
			end
		end
	end

	def is_correct_user(user_id)
		if session[:user_id] != user_id
			redirect_back fallback_location: feed_path, flash:{alert: "Access denied!"}
			#redirect_to main_path, alert: "Access denied!"
		end
	end

	def set_current_user
      @current_user = User.find(session[:user_id])
    end

  def set_user_by_name
      @user = User.find_by(name: params[:name])
  end

end