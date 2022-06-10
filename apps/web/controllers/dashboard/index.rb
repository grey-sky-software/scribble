require './apps/web/mixins/check_authentication'

module Web::Controllers::Dashboard
  # GET /
  # Responsible for querying any data needed to render the dashboard view.
  class Index
    include CheckAuthentication
    include Web::Action

    # @return [Boolean]
    #   Whether or not the user is authenticated.
    #   Used to know whether we should save the note locally or not.
    expose :authenticated?

    def call(_)
    end
  end
end
