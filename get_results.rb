require File.expand_path('../boot', __FILE__)

consumer = OAuth::Consumer.new CONSUMER_KEY, CONSUMER_SECRET, {
  :signature_method   => 'HMAC-SHA1',
  :site               => 'https://www.google.com',
  :request_token_path => '/accounts/OAuthGetRequestToken',
  :authorize_path     => '/accounts/OAuthAuthorizeToken',
  :access_token_path  => '/accounts/OAuthGetAccessToken',
}
access_token = OAuth::AccessToken.new(consumer, ACCESS_TOKEN, ACCESS_SECRET)

if ARGV[0]
  id = ARGV[0]
else
  id = PROFILE
end

Garb::Session.access_token = access_token
profile = Garb::Management::Profile.all.detect {|p| p.web_property_id == id}
puts 'set arg Analytics profile id you wanto to check' and exit if profile.nil?

class SiteUsage
  extend Garb::Model

  metrics :visitors, :percent_new_visits, :visits, :avg_time_on_site, :pageviews, :pageviews_per_visit, :visit_bounce_rate
end

class PageTitle
  extend Garb::Model

  metrics :pageviews
  dimensions :hostname, :page_path, :page_title
end

class Keyword
  extend Garb::Model

  metrics :visits
  dimensions :keyword
end

class ReferralPath
  extend Garb::Model

  metrics :visits
  dimensions :referral_path, :source
end

target_date = Date.today - 1
defaults = {
  :limit => 20,
  :start_date => target_date,
  :end_date => target_date,
}
rs_su = profile.site_usage(defaults)
rs_pt = profile.page_title(defaults.merge(:sort => :pageviews.desc))
rs_k = profile.keyword(defaults.merge(:sort => :visits.desc))
rs_rp = profile.referral_path(defaults.merge(:sort => :visits.desc))

puts "# Results for #{target_date.to_s} #{profile.title}"
puts
puts "# SiteUsage\n####################"
puts
rs_su.each do |r|
  puts r.visits + " visits"
  puts r.pageviews + " pageviews"
  puts r.visitors + " visitors"
  puts r.pageviews_per_visit + " pages/visit"
  puts r.visit_bounce_rate + " bounce rate"
  puts r.avg_time_on_site + " avg. time on site"
  puts r.percent_new_visits + " % new visits"
  puts
end
puts "# PageTitle\n####################"
puts
rs_pt.each do |r|
  puts r.pageviews + "\n" + r.page_title + "\n" + r.hostname + r.page_path
  puts
end
puts "# Keyword\n####################"
puts
rs_k.each do |r|
  puts r.visits + "\n" + r.keyword
  puts
end
puts "# ReferralPath\n####################"
puts
rs_rp.each do |r|
  puts r.visits + "\n" + r.source + r.referral_path
  puts
end
