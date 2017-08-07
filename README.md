# Shorty, a URL-Shortening Service

Shorty is a simple Rails app that can provide URL-shortening services either through a simple JSON API or through the web app.

## Features

### The smallest URL-compatible URLs
Shorty works by converting your URLs into a Base-65-encoded number for the smallest possible URL.

### URL Toolbar integration
Shorty comes with a link you can drag to your toolbar to provide URL-shortening services from the current page you are currently browsing.

## Requirements

Ruby 2.2+ / Rails 5

## Deployment

1. `bundle install`
2. `rake db:migrate`
3. `bin/rails server`

## Running the test suite

`bin/rails test`

