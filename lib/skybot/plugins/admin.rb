module Skybot
  module Plugins
    class Admin
      include Cinch::Plugin
      include Skybot::Plugins::CommandHandler

      set prefix: '?', plugin_name: 'admin'
      match(/admin\s+(.+)/)

      def commands
        [
            Skybot::CommandInfo.new('?admin acl set <user> <level>', 'Gives <user> access level <level>'),
            Skybot::CommandInfo.new('?admin acl rem <user>', 'Removes any access level from <user>'),
            Skybot::CommandInfo.new('?admin acl get <user>', 'Prints the access level for <user>'),
            Skybot::CommandInfo.new('?admin acl save', 'Saves the current user/access levels'),
            # Skybot::CommandInfo.new('?admin factoid reserve <name>', 'Reserves the given factoid <name>'),
            # Skybot::CommandInfo.new('?admin factoid free <name>', 'Frees the given factoid <name>')
        ]
      end

      def execute(msg, args)
        pass(msg, args, 0)
      end

      def cmd_acl_set(msg, args)
        user, level = *(args.shift(2))
        if user && level
          bot.acl.set user, level.to_i
        else
          msg.channel.msg 'Invalid usage!'
        end
      end

      def cmd_acl_rem(msg, args)
        user = args.shift
        if user
          bot.acl.rm user
        else
          msg.channel.msg 'Invalid usage!'
        end
      end

      def cmd_acl_get(msg, args)
        user = args.shift
        if user
          msg.channel.msg bot.acl.get user
        else
          msg.channel.msg 'Invalid usage!'
        end
      end

      def cmd_acl_save(msg, _)
        begin
          bot.acl.save
        rescue => e
          puts e
          puts e.backtrace
        end
        msg.channel.msg 'Saved successfully'
      end
    end
  end
end