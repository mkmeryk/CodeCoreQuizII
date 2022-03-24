class ApplicationController < ActionController::Base
    def authenticate_user!
        if !user_signed_in?
            flash.notice = "Please sign in first!"
            redirect_to new_session_path
        end
    end

    def user_signed_in?
        current_user.present?
    end
    helper_method :user_signed_in?

    def current_user
        @current_user ||= User.find_by_id session[:user_id]
    end
    helper_method :current_user
end
