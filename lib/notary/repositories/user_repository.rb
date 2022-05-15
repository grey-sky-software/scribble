require 'singleton'

class UserRepository < Hanami::Repository
  include Singleton

  def self.method_missing(method, *args)
    if instance.respond_to?(method)
      instance.send(method, *args)
    else
      super
    end
  end
end
