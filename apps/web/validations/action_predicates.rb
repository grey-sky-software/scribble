require 'hanami/validations'

# This class will hold all of the predicates that we write
# for helping with our Validations, both Action params and not.
#
# @example
#   require './apps/web/validators/action_predicates'
#   ...
#   params Class.new(Hanami::Action::Params) {
#     ActionPredicates.init(self)
#
#     validations do
#       ...
#     end
#   }
class ActionPredicates
  # Allows the provided `params` to use all of the defined
  # predicates in its validation checks.
  #
  # @return [void]
  def self.init(params)
    params.predicate(:json?, message: 'must be JSON') do |current|
      Json.valid?(current) || current.is_a?(Hash)
    end
  end
end
