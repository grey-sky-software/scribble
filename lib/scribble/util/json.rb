require 'oj'

Oj.default_options = {
  mode: :rails,
}

# This is a wrapper for JSON utilities such as building and parsing.
# It allows us to write all of our code using this helper class,
# while using whichever JSON engine we want behind the scenes.
class Json
  def self.method_missing(method, *args)
    Oj.send(method, *args)
  end

  def self.build(hash)
    Oj.dump(hash)
  end

  def self.parse(str, *args)
    Oj.load(str, *args)
  end

  def self.valid?(str)
    parse(str)
    true
  rescue ArgumentError, EncodingError, JSON::ParserError
    false
  end
end
