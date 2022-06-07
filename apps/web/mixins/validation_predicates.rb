require 'hanami/validations'

module ValidationPredicates
  include Hanami::Validations::Predicates

  predicate(:array?, message: 'is not an array') do |current|
    current.is_a?(Array)
  end
end
