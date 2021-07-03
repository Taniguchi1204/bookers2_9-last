class UserMailer < ApplicationMailer
  def create_event(group_users, title, content)
    @title = title
    @content = content
    mail bcc: group_users.pluck(:email), subject: title
  end
end
