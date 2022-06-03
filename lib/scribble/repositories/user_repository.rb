require 'singleton'

class UserRepository < Hanami::Repository
  include Singleton

  def self.method_missing(method, *args)
    if instance.respond_to?(method)
      instance.send(method, *args)
    elsif users.respond_to?(method)
      users.send(method, *args)
    else
      super
    end
  end
end
