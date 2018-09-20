FROM ruby:2.3.1-slim

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev git nodejs sqlite3 libsqlite3-dev

# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/lombardpress-web

# Create application home.
RUN mkdir -p $RAILS_ROOT

# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
# (the src likely changed and we don't want to invalidate Docker's cache too early)
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
COPY Gemfile Gemfile

COPY Gemfile.lock Gemfile.lock

# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler

# Finish establishing our Ruby enviornment
RUN bundle install

# Copy the Rails application into place
COPY . .

EXPOSE 3000

CMD bundle exec puma -C config/puma.rb
