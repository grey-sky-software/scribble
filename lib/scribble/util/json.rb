require 'oj'

class Json
  def self.method_missing(method, *args)
    Oj.send(method, *args)
  end

  def self.build(hash)
    Oj.dump(hash)
  end

  def self.parse(str, symbolize: true)
    Oj.load(str, symbolize_names: symbolize)
  end
end
