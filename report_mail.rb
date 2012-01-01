require File.expand_path('../boot', __FILE__)

reporter = Reporter.new(ARGV[0])
output = reporter.all

Pony.mail(
  :via => :sendmail,
  :via_options => {
    :location => '/usr/sbin/sendmail',
  },
  :from => MAIL_FROM,
  :to => MAIL_TO,
  :subject => "Analytics Summary #{Date.today - 1}",
  :body => output,
  :charset => 'utf-8'
)
