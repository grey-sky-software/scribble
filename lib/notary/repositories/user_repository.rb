class UserRepository < Hanami::Repository

  def instance
    @repo ||= UserRepository.new
  end

end
