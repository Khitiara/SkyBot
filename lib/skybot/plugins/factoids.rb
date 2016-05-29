require 'active_support/core_ext/array/grouping'
require 'skybot/util/array_ext'

module Skybot::Plugins
  class Factoids
    include Cinch::Plugin

    set prefix: '?', plugin_name: 'factoids'
    match /([a-zA-Z]+)(.*)/

    def execute(m, c, as)
      aa = Shellwords.split as
      a = aa.split '>'
      process(m, c, a, nil)
    end

    def process(m, c, a, p)
      args = a.shift
      args.find_and_replace!('!!', p) unless p.nil?
      args.find_and_replace!('\n', "\n")
      resp = run(c, args)
      if a.empty?

      else

      end
    end
  end
end