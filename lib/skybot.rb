require 'rubygems'
require 'bundler'
Bundler.require :default

require 'cinch'
require 'yajl'
require 'active_support/inflector'
require 'active_support/core_ext/hash/indifferent_access'

require 'skybot/version'
require 'skybot/acl'
require 'skybot/command_info'
require 'skybot/plugins'

require 'skybot/sky_bot'