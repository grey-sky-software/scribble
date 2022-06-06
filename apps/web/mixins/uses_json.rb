# Include this module in an action and pass the `self` instance of the action
# to the `use_json` method to make that action accept and respond with JSON
module UsesJson
  def use_json(action)
    action.send(:accept)
    self.format = :json
  end
end
