# If you have OpenSSL installed, we recommend updating
# the following line to use "https"
source 'http://rubygems.org'

gem "middleman"
gem "middleman-blog"
gem "middleman-core"
# Live-reloading plugin
gem "middleman-livereload", "~> 3.1.0"
gem 'middleman-deploy', '~> 0.3.0'
gem 'thin'
gem 'foreman'
gem "chronic"
gem "dotenv"

# For faster file watcher updates on Windows:
gem "wdm", "~> 0.1.0", :platforms => [:mswin, :mingw]

# Cross-templating language block fix for Ruby 1.8
platforms :mri_18 do
  gem "ruby18_source_location"
end
