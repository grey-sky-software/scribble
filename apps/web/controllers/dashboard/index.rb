module Web
  module Controllers
    module Dashboard
      class Index
        include Web::Action

        # @return [Boolean]
        #   whether or not the user is authenticated
        #   used to know whether we should save the note locally or not
        expose :authenticated

        def call(params)
          # @TODO
          #   set this value using the current authentication status
          @authenticated = false
        end
      end
    end
  end
end
