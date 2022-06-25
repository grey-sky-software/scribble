require 'oj'

Oj.default_options = {
  mode: :rails,
}

# This is a wrapper for JSON utilities such as building and parsing.
# It allows us to write all of our code using this helper class,
# while using whichever JSON library we want behind the scenes.
class Json
  # Any methods that are called on our wrapper class that we haven't provided
  # an explicit custom implementation for should be passed on to the
  # wrapped library.
  #
  # @return [any]
  def self.method_missing(method, *args, &block)
    Oj.send(method, *args, &block)
  end

  # Create a JSON string out the provided hash.
  #
  # @param [Hash] hash
  #   The hash we want to build into a JSON string.
  #
  # @return [String]
  #   The JSON string built from the provided hash.
  def self.build(hash)
    Oj.dump(hash)
  end

  # Parses the provided JSON string into a hash.
  #
  # @param [String] str
  #   The JSON string that we want to parse into a {Hash}.
  # @param [any] args
  #   Any additional arguments we want to pass to the library's parser.
  #   (ex. `symbolize_names: true`)
  #
  # @return [Hash]
  #   The hash created out of the provided JSON string.
  def self.parse(str, *args)
    Oj.load(str, *args)
  end

  # Checks if the provided string is valid JSON by attempting to parse it.
  # If a parsing error is thrown, we consider the string not valid JSON.
  #
  # @param [String] str
  #   The JSON string that we want to validate.
  #
  # @return [Boolean]
  #   Whether or not the provided string is valid JSON.
  def self.valid?(str)
    parse(str)
    true
  rescue ArgumentError, EncodingError, JSON::ParserError
    false
  end
end
