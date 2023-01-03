class RepliesMailbox < ApplicationMailbox
  def process
    return if user.nil?
  end

  def user
    @user ||= User.find_by(email: mail.from)
  end

  def discussion
    @discussion ||= Discussion.find(discussion_id)
  end

  def discussion_id

  end

  def ensure_user
    if user.nil?
      bounce_with UserMailer.missing(inbound_email)
    end
  end
end
