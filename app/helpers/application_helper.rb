module ApplicationHelper
  def full_title(title)
    title
  end

  def full_name(user)
    "#{user.first_name.capitalize} #{user.last_name.capitalize}"
  end
end
