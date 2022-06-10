require 'hanami/validations'

class ActionPredicates
  def self.init(params)
    params.predicate(:json?, message: 'must be JSON') do |current|
      Json.valid?(current) || current.is_a?(Hash)
    end
  end
end
