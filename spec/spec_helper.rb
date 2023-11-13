# frozen_string_literal: true

require 'simplecov'
require 'faker'
require 'pry'

SimpleCov.start

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end

RSpec::Expectations.configuration.warn_about_potential_false_positives = false
