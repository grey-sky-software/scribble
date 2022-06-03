require './apps/web/mixins/check_authentication'

module Web
  module Controllers
    module Dashboard
      class Index
        include CheckAuthentication
        include Web::Action

        # @return [Boolean]
        #   whether or not the user is authenticated
        #   used to know whether we should save the note locally or not
        expose :authenticated?

        def call(params)
        end
      end
    end
  end
end
