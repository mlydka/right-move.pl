# -*- coding: utf-8 -*-
# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'spec'
require 'spec/rails'

include AuthenticatedTestHelper

Spec::Runner.configure do |config|
  # If you're not using ActiveRecord you should remove these
  # lines, delete config/database.yml and disable :active_record
  # in your config/boot.rb
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  # == Fixtures
  #
  # You can declare fixtures for each example_group like this:
  #   describe "...." do
  #     fixtures :table_a, :table_b
  #
  # Alternatively, if you prefer to declare them only once, you can
  # do so right here. Just uncomment the next line and replace the fixture
  # names with your fixtures.
  #
  # config.global_fixtures = :table_a, :table_b
  #
  # If you declare global fixtures, be aware that they will be declared
  # for all of your examples, even those that don't use them.
  #
  # You can also declare which fixtures to use (for example fixtures for test/fixtures):
  #
  # config.fixture_path = RAILS_ROOT + '/spec/fixtures/'
  #
  # == Mock Framework
  #
  # RSpec uses it's own mocking framework by default. If you prefer to
  # use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr
  #
  # == Notes
  # 
  # For more information take a look at Spec::Example::Configuration and Spec::Runner
end


def create_address(options ={})
  Address.create({:firstname => 'Jerzy', :lastname => 'Nowak', :city => 'Głogów', :street => 'Królewska', :apartment => '342a/3', :zip => '32-123', :email => 'jnowak@example.net', :phone => '645 12 43'}.merge(options))
end


class RenderNothing
  def initialize
  end

  def matches?(controller)
    @actual = controller.rendered_template
    @actual == nil
  end

  def failure_message
    return "render_nothing expected (render :nothing => true), got #{@actual.inspect}"
  end

  def negative_failure_message
    return "render_nothing expected (render :nothing => true) not to equal #{@actual.inspect}"
  end
end

def render_nothing
  RenderNothing.new
end
