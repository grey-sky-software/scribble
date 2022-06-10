# Include this module in an action and pass the `self` instance of the action
# to the `use_json` method to make that action accept and respond with JSON.
#
# @example
#   require './apps/web/mixins/uses_json'
#   ...
#   include UsesJson
#   ...
#   before { use_json(self) }
module UsesJson
  # Configures the provided `action` for accepting in and responding with JSON.
  #
  # @return [void]
  def use_json(action)
    action.send(:accept)
    self.format = :json
  end
end
