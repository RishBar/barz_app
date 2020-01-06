# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'noreply@barz.com'
  layout 'mailer'
end
