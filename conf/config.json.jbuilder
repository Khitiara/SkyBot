json.owner conf.owner
json.info conf.info
json.bot do
  json.nick conf.nick
  json.realname conf.realname
  json.user conf.username
  json.server conf.server
  json.channels conf.channels
  if conf.sasl
    json.sasl do
      json.username conf.sasl_username
      json.password conf.sasl_password
    end
  end
  json.plugins do
    json.plugins %w(Skybot::Plugins::Admin
      Skybot::Plugins::Github
      Skybot::Plugins::HttpServer)
    json.options do
      # json.set! 'Skybot::Plugins::Factoids' do
      # json.filename 'factoids.json'
      # end
      json.set! 'Skybot::Plugins::Github' do
        json.repos conf.repos
      end
      json.set! 'Skybot::Plugins::HttpServer' do
        json.host '0.0.0.0'
        json.port conf.port
      end
    end
  end
end