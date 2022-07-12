require 'singleton'

# The {Repository} responsible for allowing a
# {UserSettings} to interface with the database.
class UserSettingsRepository < Hanami::Repository
  include Singleton

  associations do
    belongs_to :user
  end

  # Determines if the provided method is available on the `#instance` of this
  # {Repository}, or on the existing {ROM::Relation::Composite} `user_settings`
  # and sends the method to the first object that responds to it.
  # Otherwise, send it up the chain.
  def self.method_missing(method, *args, &block)
    if instance.respond_to?(method)
      instance.send(method, *args, &block)
    elsif user_settings.respond_to?(method)
      user_settings.send(method, *args, &block)
    else
      super
    end
  end

  # Exposes the `#transaction` functionality so that it becomes easier
  # for us to start a transaction on this {Repository}.
  def self.transaction(&block)
    configuration.connection.transaction(&block)
  end

  # @param [UUID] user_id
  #   The ID of the {User} who this {UserSettings} belongs to.
  #
  # @return [ROM::Struct::User]
  #   The {User} who this {UserSettings} belongs to.
  def user_for(user_id:)
    users.where(id: user_id).first
  end
end
