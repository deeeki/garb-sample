# coding: utf-8
require File.expand_path('../boot', __FILE__)

Pony.mail(
  :via => :sendmail,
  :via_options => {
    :location => '/usr/sbin/sendmail',
  },
  :from => MAIL_FROM,
  :to => MAIL_TO,
  :subject => "Analytics Summary #{Date.today - 1}",
  :body => STDIN.read,
  :charset => 'utf-8'
)
