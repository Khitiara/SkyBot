module Skybot::Plugins::Factoids
  class Store
    def initialize(filename)
      @factoid_filename = filename
      read
    end

    attr_reader :reserved, :user

    def factoids
      @user.merge @reserved
    end

    def reserve_factoid(name)
      @reserved[name] = @user.delete name
    end

    def free_factoid(name)
      @user[name] = @reserved.delete name
    end

    def read
      parsed = Yajl.load(File.open @factoid_filename)
      @reserved = parsed['reserved'] || {}
      @user = parsed['user'] || {}
    end

    def save!
      data = {
          reserved: @reserved,
          user:     @user
      }
      File.write @factoid_filename, JSON.pretty_unparse(data)
    end
  end
end