# Garb custom classes definition
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

