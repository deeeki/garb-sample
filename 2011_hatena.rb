require File.expand_path('../boot', __FILE__)

#access
reporter = Garb::Reporter.new()
rs = reporter.profile.page_title({
  :limit => 50,
  :sort => :pageviews.desc,
  :start_date => Date.new(2011, 1, 1),
  :end_date => Date.new(2011, 12, 31),
})

o = []
rs.each_with_index do |r, i|
  o << [
    '|',
    i + 1,
    '|',
    "[http://#{r.hostname}#{r.page_path}:title:bookmark]#{' (touch)' if r.page_path.include?('touch')}",
    '|',
    r.pageviews,
    '|',
    r.page_path.split('/').reject{|p| p == 'touch' }[2].to_s[0..3],
    '|',
  ].join
end
puts o.join("\n")

#keyword
rs = reporter.profile.keyword({
  :limit => 21,
  :sort => :visits.desc,
  :start_date => Date.new(2011, 1, 1),
  :end_date => Date.new(2011, 12, 31),
})

o = []
rs.each_with_index do |r, i|
  next if i.zero?
  o << [
    '|',
    i,
    '|',
    "[google:#{r.keyword}]",
    '|',
    r.visits,
    '|',
  ].join
end
puts o.join("\n")
