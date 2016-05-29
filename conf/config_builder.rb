require 'jbuilder'
require 'highline'
require 'ostruct'
require 'multi_json'
require_relative 'template_madness'

module Skybot
  class ConfigBuilder
    def initialize
      @term = HighLine.new
    end

    delegate :agree, :say, :indent, :ask, to: :@term

    def create
      if File.exist? 'config.json'
        return unless agree('config.json already exists, do you want to overwrite it? ')
      end

      variables = { info: nil }
      if agree('Do you want to get help setting up your config? ')
        variables[:owner] = ask 'Bot owner irc nick'
        variables[:info]  = ask 'Information to display with help command: '
        variables.merge!(query_irc).merge(query_http).merge(query_github)
      end
      s = OpenStruct.new variables
      MultiJson.use :yajl
      template = Template.new(IO.read(File.expand_path('../config.json.jbuilder', __FILE__)))
      IO.write 'config.json', template.render(self, conf: s).strip
    end

    def query_github
      variables = {
          repos: {}
      }

      say 'Github Setup'
      indent do
        if agree('Do you want to set up Github? ')
          until (repo = ask('Enter repo name (user/repo):')).empty?
            chans = []
            until (chan = ask('Enter irc channel name:')).empty?
              chans << chan
            end
            variables[:repos][repo] = chans
          end
        end
      end

      variables
    end

    def query_http
      variables        = {
          port: 4567
      }
      variables[:port] = ask('Http Port (default 4567): ')
      variables
    end

    def query_irc
      variables = { server:        nil,
                    channels:      [],
                    nick:          nil,
                    realname:      nil,
                    username:      nil,
                    sasl_username: nil,
                    sasl_password: nil,
                    sasl:          false }

      say 'IRC Setup'
      indent do
        variables[:server] = ask 'IRC Server: '
        if agree('Do you want to set channels? Enter blank to stop.')
          chans = []
          indent do
            until (chan = ask('Enter irc channel name:')).empty?
              chans << chan
            end
          end
          variables[:chans] = chans
        end
        variables[:nick]     = ask 'Bot nickname: '
        variables[:realname] = ask('Bot realname: ') { |q| q.default = variables[:nick] }
        variables[:username] = ask('Bot username: ') { |q| q.default = variables[:nick] }
        if agree('Set up SASL? ')
          indent do
            variables[:sasl_username] = ask 'SASL username: '
            variables[:sasl_password] = ask('SASL password: ') { |q| q.echo = '*' }
            variables[:sasl]          = true
          end
        end
      end

      variables
    end
  end
end