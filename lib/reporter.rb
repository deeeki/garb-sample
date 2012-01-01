require File.expand_path('../garb/reporter', __FILE__)

class Reporter < Garb::Reporter
  def initialize(web_property_id = nil)
    super
    @target_date = Date.today - 1
    @default_options = {
      :limit => 20,
      :start_date => @target_date,
      :end_date => @target_date,
    }
  end

  def all
    [
      title,
      site_usage,
      page_title,
      keyword,
      referral_path,
    ].join("\n\n")
  end

  def title
    "# Results for #{@target_date.to_s} #{profile.title}"
  end

  def bar(length = 20)
    '#' * length
  end

  def site_usage
    ret = ['# SiteUsage', bar, '']
    ret << profile.site_usage(@default_options).map do |r|
      [
        "#{r.visits} visits",
        "#{r.pageviews} pageviews",
        "#{r.visitors} visitors",
        "#{r.pageviews_per_visit.to_f.round(2)} pages/visit",
        "#{r.visit_bounce_rate.to_f.round(2)} bounce rate",
        "#{r.avg_time_on_site.to_f.round(2)} avg. time on site",
        "#{r.percent_new_visits.to_f.round(2)} % new visits",
        '',
      ]
    end
    ret.compact.join("\n")
  end

  def page_title
    ret = ['# PageTitle', bar, '']
    ret << profile.page_title(@default_options.merge(:sort => :pageviews.desc)).map do |r|
      [
        r.pageviews,
        r.page_title,
        "#{r.hostname}#{r.page_path}",
        '',
      ]
    end
    ret.compact.join("\n")
  end

  def keyword
    ret = ['# Keyword', bar, '']
    ret << profile.keyword(@default_options.merge(:sort => :visits.desc)).map do |r|
      [
        r.visits,
        r.keyword,
        '',
      ]
    end
    ret.compact.join("\n")
  end

  def referral_path
    ret = ['# ReferralPath', bar, '']
    ret << profile.referral_path(@default_options.merge(:sort => :visits.desc)).map do |r|
      [
        r.visits,
        "#{r.source}#{r.referral_path}",
        '',
      ]
    end
    ret.compact.join("\n")
  end
end
