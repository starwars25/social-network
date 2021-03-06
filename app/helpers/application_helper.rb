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

  def dialog_name(dialog)
    if dialog.members.count > 2
      dialog.name
    else
      dialog.members.each { |member| return member.username unless member == current_user}
    end
  end
end
