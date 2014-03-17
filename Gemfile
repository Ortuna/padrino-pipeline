source 'https://rubygems.org'

gemspec 
gem "rake"
(RUBY_VERSION < "1.9") ? gem("nokogiri",  "~> 1.5.10") : gem("nokogiri",  "~> 1.6")

group :test do
  gem "rack-test", ">= 0.5.0"
  gem "minitest",  "~> 4.0"
  gem "bootstrap-sass", "~> 3.1"
end
