module Skybot
  module Plugins
    module CommandHandler
      def pass(msg, full_cmd, auth_level)
        return unless bot.acl.auth_or_fail(msg.channel, msg.user, auth_level)
        args = Shellwords.split full_cmd
        try_pass msg, args, 'cmd'
      end

      def try_pass(msg, args, base)
        fun = "#{base}_#{args.shift}"
        if respond_to? fun
          puts "Sending #{fun}"
          send fun, msg, args
        elsif args.length > 0
          puts 'Recursing...'
          try_pass(msg, args, fun)
        else
          puts 'No handler found'
          msg.channel.send 'Unknown command!'
        end
      end
    end
  end
end