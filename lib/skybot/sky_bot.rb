
class SkyBot < Cinch::Bot
  attr_reader :bot_config
  attr_reader :acl
  attr_reader :owner

  def initialize(data = {})
    super()
    @cfg_filename = data[:cfg_filename] || 'config.json'
    reload_conf!
  end

  def save_conf!
    File.write @cfg_filename, JSON.pretty_generate(@bot_config)
    reload_conf!
  end

  def reload_conf!
    @cfg_file   = File.read @cfg_filename
    @bot_config = Yajl::Parser.parse @cfg_file, symbolize_names: true
    @owner      = @bot_config[:owner]
    @acl        = Skybot::Acl.new(self)

    # load plugins
    @bot_config[:bot][:plugins][:plugins].each { |clazz| require ActiveSupport::Inflector.underscore clazz }
    @bot_config[:bot][:plugins][:options] =
        Hash[@bot_config[:bot][:plugins][:options].map { |k, v| [ActiveSupport::Inflector.constantize(k.to_s), v] }]
    config.load @bot_config[:bot]
  end
end