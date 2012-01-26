# coding: utf-8
require File.expand_path('../boot', __FILE__)
@config_mail ||= YAML.load_file 'config/mail.yml'

Pony.mail(
  :via => :sendmail,
  :via_options => {
    :location => '/usr/sbin/sendmail',
  },
  :from => @config_mail['from'],
  :to => @config_mail['to'],
  :subject => "Analytics Summary #{Date.today - 1}",
  :body => STDIN.read,
  :charset => 'utf-8'
)
