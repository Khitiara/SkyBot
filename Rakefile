require "bundler/gem_tasks"
task :default => :spec

namespace :skybot do
  desc 'Runs the skybot'
  task :run do
    system 'bundle exec bin/skybot'
  end

  desc 'Creates the config'
  task :create_config do
    require_relative 'conf/config_builder'
    Skybot::ConfigBuilder.new.create
  end
end