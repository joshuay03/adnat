module SessionsHelper
  # Logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end

  # Logs out the given user
  def log_out(user)
    session[:user_id] = nil
  end

  # Returns the current logged-in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
