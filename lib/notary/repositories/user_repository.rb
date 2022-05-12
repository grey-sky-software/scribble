class UserRepository < Hanami::Repository
  def self.instance
    @repo ||= UserRepository.new
  end

  def self.method_missing(method, *args)
    if instance.respond_to?(method)
      instance.send(method, *args)
    else
      super
    end
  end
end
