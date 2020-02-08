# frozen_string_literal: true

class PostsMailer < ApplicationMailer
  def new_post_notification(post, membership)
    @post = post
    mail(
      :subject => translate(".new_post", :group_name => post.group.name),
      :to => membership.email
    )
  end
end
