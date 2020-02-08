# frozen_string_literal: true

class PostsMailbox < ApplicationMailbox
  def process
    sender = mail.from
    user = User.find_by_email(sender)
    if user
      process_mail_from_user(user)
    else
      # TODO: Respond and say we couldn't find you
      bounced!
    end
  end

  private

  def create_post(membership)
    group = membership.group
    group.posts.create!(
      :membership => membership,
      :body => mail.body,
      :raw_text_body => mail.text_part,
      :raw_html_body => mail.html_part
    )
  end

  def find_group_by_email_address(user, recipient)
    group_name = recipient.split("@").first
    user.groups.where("lower(groups.name) = ?", group_name.downcase).first
  end

  def notify_members(post, group)
    group.memberships.each do |recipient|
      next if recipient == post.membership

      PostsMailer.new_post_notification(post, recipient).deliver_later
    end
  end

  def process_mail_from_user(user)
    groups = mail.to.map do |recipient|
      find_group_by_email_address(user, recipient)
    end.compact

    if groups.any?
      groups.each do |group|
        process_mail_from_user_to_group(user, group)
      end
    else
      # TODO: Respond and say we couldn't find that group
      bounced!
    end
  end

  def process_mail_from_user_to_group(user, group)
    Rails.logger.debug {
      "[#{self.class}] RECEIVED A POST FROM #{user} TO #{group}"
    }

    membership = group.memberships.find_by!(:user => user)
    post = create_post(membership)
    notify_members(post, group)
  end
end
