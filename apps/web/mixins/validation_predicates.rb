require 'hanami/validations'

module ValidationPredicates
  include Hanami::Validations::Predicates

  predicate(:array?) do |current|
    current.is_a?(Array)
  end
end
