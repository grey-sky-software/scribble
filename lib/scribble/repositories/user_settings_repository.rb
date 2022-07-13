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
  # @param [String, Symbol] name
  #   The name of the setting that we want to update the value for.
  # @param [any] value
  #   The value that we want to assign to this setting.
  # @return [void]
  # @raise [ROM::Struct::MissingAttribute]
  #   If no setting exists with the provided `name`.
  def update_setting_for(user_id:, name:, value:)
    setting = user_settings.where(user_id: user_id)
    values = setting.as(:entity).first.values

    raise ROM::Struct::MissingAttribute, "UserSettings do not have a setting named '#{name}'" unless
      values.key?(name.to_sym)

    values[name.to_sym] = value
    setting.update(value: Json.build(values))
  end

  # @param [UUID] user_id
  #   The ID of the {User} who this {UserSettings} belongs to.
  # @param [Hash] payload
  #   The payload of `{ attribute: value }` pairs that we want to use to
  #   update the stored settings.
  # @return [void]
  # @raise [ROM::Struct::MissingAttribute]
  #   If any of the attributes provided in the payload do not match a valid setting.
  def update_settings_for(user_id:, payload:)
    setting = user_settings.where(user_id: user_id)
    values = setting.as(:entity).first.values

    unknown_settings = payload.keys - values.keys
    if unknown_settings.present?
      raise ROM::Struct::MissingAttribute,
        "Unknown setting names provided: '#{unknown_settings.join('\', \'')}'"
    end

    new_values = values.merge(payload)
    setting.update(value: Json.build(new_values))
  end

  # @param [UUID] user_id
  #   The ID of the {User} who this {UserSettings} belongs to.
  #
  # @return [User]
  #   The {User} who this {UserSettings} belongs to.
  def user_for(user_id:)
    users.where(id: user_id).as(:entity).first
  end
end
