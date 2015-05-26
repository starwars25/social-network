module ApplicationHelper
  def full_title(title)
    title
  end

  def full_name(user)
    if !user.first_name.nil? && !user.last_name.nil?
      "#{user.first_name.capitalize} #{user.last_name.capitalize}"
    else
      user.username
    end
  end
end
