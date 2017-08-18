source 'https://rubygems.org'
#ruby "2.2.2"
ruby RUBY_VERSION
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views

### Javascript assets
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

## adding support for sprokcets es6
gem 'sprockets-es6', require: 'sprockets/es6'

# Use jquery as the JavaScript library
gem 'jquery-rails'

## mousetrap keyboard shortcuts gem read more at: https://github.com/kugaevsky/mousetrap-rails
gem 'mousetrap-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'bootstrap-sass', '~> 3.2.0'

gem 'autoprefixer-rails'

#gem 'devise'
gem 'devise', '~> 3'
gem 'devise-i18n'

## rails to include rich text editor in asset pipeline
gem 'ckeditor_rails'

#handle bars assets allows me to call HandlebarsTemplates['template'](data) in javascript files
gem 'handlebars_assets', :git => "https://github.com/leshill/handlebars_assets.git"

gem 'lbp', :git => "https://github.com/lombardpress/lbp.rb.git", :branch => "develop"
#gem 'lbp'

gem 'osullivan'

# Use ActiveModel has_secure_password
 gem 'bcrypt', '~> 3.1.7'

 gem 'pundit'


# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
group :production do
  gem 'pg'
  # Use Unicorn as the app server
  # gem 'unicorn'
  # Using Puma as web server
  gem 'puma'

  ## email server for production
  gem 'postmark-rails', '~> 0.12.0'


end

group :development, :test do
	# Use sqlite3 as the database for Active Record
	gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'pry'

  gem 'thin'
  # use letter opener for development email
  gem "letter_opener"

end

# Access an IRB console on exception pages or by using <%= console %> in views
gem 'web-console', '~> 2.0', group: :development

#rails-assets
source 'https://rails-assets.org' do
end
