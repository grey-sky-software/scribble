require './lib/scribble/repositories/user_settings_repository'

# A {UserSettings} represents the collection of site preferences chosen by the {User}.
class UserSettings < Hanami::Entity
  # Allows us to call all of the repository methods directly on the entity
  # for convenience such as `UserSettings.first` or `UserSettings.create`.
  def self.method_missing(method, *args, &block)
    UserSettingsRepository.send(method, *args, &block)
  end

  # Allows us to call repository methods for an instance of the entity on an
  # instance of the entity, such as `UserSettings.find(1).update(...)`.
  def method_missing(method, *args, &block)
    return hashed[method.to_sym] if hashed.key?(method.to_sym)
    UserSettingsRepository.send(method, id, *args, &block)
  end

  # @return [User]
  #   The {User} who this {UserSettings} belongs to.
  def user
    UserSettingsRepository.user_for(user_id: user_id)
  end

  # @return [Hash]
  #   The hash of `{ attribute: value }` pairs stored on this {UserSettings} entity.
  def values
    hashed[:value]
  end

  # @note
  #   If the provided `key` is an attribute in the {UserSettings} `value` object, then that
  #   setting attribute's value will be returned.
  #   Otherwise, will return the attribute from the {UserSettings} entity itself that matches
  #   the `key`, if one exists.
  #   Will raise an error if no attribute can be found on either object with the provided `key`.
  # @example
  #   user_settings = User.find('1a2b3c').settings => {UserSettings}
  #   user_settings[:user_id] => '1a2b3c'
  #   user_settings[:value] => { dark_mode: true, editor: 'fancy' }
  #   user_settings[:dark_mode] => true
  # @param [Symbol, String]
  #   The name of the attribute we want to retrieve the value of from the object.
  # @return [any]
  #   The value associated with the provided attribute key on this object, if the object
  #   has an attribute matching the provided key.
  # @raise [ROM::Struct::MissingAttribute]
  #   If the object does not have a matching attribute.
  def [](key)
    sym_key = key.to_sym
    return values[sym_key] if values.key?(sym_key)
    return hashed[sym_key] if hashed.key?(sym_key)
    raise ROM::Struct::MissingAttribute, "No attribute '#{key}' for object '#{self.class.name}'"
  end

  private

  # @return [Hash]
  #   The current {UserSettings} converted to a {Hash} for accessing its attributes.
  def hashed
    to_h
  end
end
