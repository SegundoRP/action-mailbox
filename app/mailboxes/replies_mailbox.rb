class RepliesMailbox < ApplicationMailbox
  MATCHER = /reply-(.+)@reply.example.com/i
  def process
    return if user.nil?

    discussion.comments
  end

  def user
    @user ||= User.find_by(email: mail.from)
  end

  def discussion
    @discussion ||= Discussion.find(discussion_id)
  end

  def discussion_id
    recipient = mail.recipients.find{ |r| MATCHER.match?(r)}
    recipient[MATCHER, 1]
  end

  def ensure_user
    if user.nil?
      bounce_with UserMailer.missing(inbound_email)
    end
  end
end
