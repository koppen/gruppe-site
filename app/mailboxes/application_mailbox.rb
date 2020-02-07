# frozen_string_literal: true

class ApplicationMailbox < ActionMailbox::Base
  routing(/^@posts\./i => :posts)
end
