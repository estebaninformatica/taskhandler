class ApplicationController < ActionController::Base
	before_filter :authenticate_user!
	
	def authenticate_admin!
  	redirect_to welcome_index_path if !current_user.admin?
  end
end
