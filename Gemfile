# frozen_string_literal: true

source 'https://rubygems.org'

puppetversion = if ENV.key?('PUPPET_VERSION')
                  "~> #{ENV['PUPPET_VERSION']}"
                else
                  ['>= 7.1.0']
                end

gem 'puppet', puppetversion
gem 'rake'
gem 'trocla'

group :tests do
  gem 'metadata-json-lint'
  gem 'puppetlabs_spec_helper'
  gem 'puppet-lint'
  gem 'puppet_metadata'
  gem 'puppet-syntax'
  # This draws in rubocop and other useful gems for puppet tests
  gem 'voxpupuli-test'
end
