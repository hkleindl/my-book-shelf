module SessionsHelper

  def login(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)  
  end

  def logged_in_user
    unless logged_in?
       flash[:danger] = "Please log in."
       redirect_to root_path
    end
 end
  
end
