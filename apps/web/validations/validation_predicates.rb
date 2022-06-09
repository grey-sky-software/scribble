require 'hanami/validations'

module ValidationPredicates
  include Hanami::Validations::Predicates

  # self.messages_path = 'config/errors.yml'

  predicate(:array?) do |current|
    current.is_a?(Array)
  end
end
