require 'date'
require 'dotenv'
Dotenv.load
###
# Compass
###
activate :blog do |blog|
  # set options on blog
end
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
# Deployment
###


case ENV['TARGET'].to_s.downcase
when 'github'
  activate :deploy do |deploy|
    deploy.method = :git
  end
else
  activate :deploy do |deploy|
    deploy.method   = :ftp
    deploy.host     = 'ftp.pitchbreakfast.com'
    deploy.path     = '/'
    deploy.user     = ENV["UNAME"]
    deploy.password = ENV["PWORD"]
  
    deploy.build_before = true
  end
end




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
    date = date.next_day until date.wednesday?
    date
  end

  def next_event_date(from_date = Date.today)
    second_wednesday_of_this_month = second_wednesday_of(from_date.month, from_date.year)
    if second_wednesday_of_this_month > from_date
      second_wednesday_of_this_month
    else
      next_month = from_date.next_month
      second_wednesday_of(next_month.month, next_month.year)
    end
  end

  def next_tb_event_date
    next_event { |date| not third_month?(date) }
  end

  def next_ifp_event_date
    next_event { |date| third_month?(date) }
  end

  def next_event_is_ifp?
    next_event_date == next_ifp_event_date
  end

  def next_event(&block)
    date = next_event_date
    date = next_event_date(date) until block.call(date)
    date
  end

  def third_month?(date)
    third_months = [1, 4, 7, 10]
    third_months.include?(date.month)
  end
end
