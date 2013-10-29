require 'date'
###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Reload the browser automatically whenever files change
# activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_path, "/Content/images/"
end

helpers do
  def second_wednesday_of(month, year)
    date = Date.parse("#{year}/#{month}/07")
    found = false
    while(!found) do
      date = date+1
      next unless date.wednesday?
      next unless (date - 14).month != date.month
      found = true
    end
    date
  end

  def next_event_date(from_date = Date.today)
    if second_wednesday_of(from_date.month, from_date.year) > from_date
      second_wednesday_of(from_date.month, from_date.year)
    else
      next_month = from_date+30
      second_wednesday_of(next_month.month, next_month.year)
    end
  end

  def next_tb_event_date
    found = false
    current_date = Date.today
    while(!found) do
      current_date = next_event_date(current_date)
      next if [1, 4, 7, 10].include?(current_date.month)
      found = true
    end
    current_date
  end

  def next_ifp_event_date
    found = false
    current_date = Date.today
    while(!found) do
      current_date = next_event_date(current_date)
      next unless [1, 4, 7, 10].include?(current_date.month)
      found = true
    end
    current_date
  end

  def next_event_is_ifp?
    next_event_date == next_ifp_event_date
  end
end
