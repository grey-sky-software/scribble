require 'oj'

Oj.default_options = {
  mode: :rails,
}

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
    self.parse(str)
    true
  rescue ArgumentError, EncodingError, JSON::ParserError
    false
  end
end
