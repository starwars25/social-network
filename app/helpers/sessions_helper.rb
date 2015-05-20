module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      # Metaprogramming
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    forget(current_user)
    session.delete :user_id

    @current_user = nil
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # I know that it is odd here but I am to lazy to create a separate class for one method
  def message
    notifications = current_user.notifications
    has_message = false
    has_request = false
    notifications.each do |notification|
      if notification.classification == 'message'
        has_message = true
      end
      if notification.classification == 'request'
        has_request = true
      end
    end
    if has_request && has_message
      return "You have some friend requests and new messages. #{link_to 'Requests', profile_path} #{link_to 'Dialogs', dialogs_user_path(current_user.id)}"

    elsif has_request
      return "You have some friend #{link_to 'Requests', profile_path}."
    elsif has_message
      return "You have some new messages #{link_to 'Dialogs', dialogs_user_path(current_user.id)}"
    end
  end
end
