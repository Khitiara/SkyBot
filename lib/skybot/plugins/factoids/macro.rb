module Skybot::Plugins::Factoids
  class Macro
    def run(msg, args_s, args, nick)
      fail 'SubclassResponsibility'
    end

    def self.impl(&blk)
      (Class.new Macro do
        def initialize(blk)
          @blk = blk
        end

        def run(m, b, c, d)
          @blk.call(m, b, c, d)
        end
      end).new(blk)
    end
  end
end