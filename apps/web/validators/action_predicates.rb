require 'hanami/validations'

# This class will hold all of the predicates that we write
# for helping with our Validations, both Action params and not.
class ActionPredicates
  def self.init(params)
    params.predicate(:json?, message: 'must be JSON') do |current|
      Json.valid?(current) || current.is_a?(Hash)
    end
  end
end
