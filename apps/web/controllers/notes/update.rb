require './apps/web/mixins/check_authentication'
#require './apps/web/mixins/uses_json'

module Web
  module Controllers
    module Notes
      class Update
        include Web::Action
        include CheckAuthentication
        #include UsesJson

        before :must_be_authenticated
        before { halt 400 unless params.valid? }
        #before { use_json(self) }

        params do
          required(:body).value(:string).filled
          required(:id).value(:string).filled
          optional(:tags).value(:array).filled
        end

        def call(params)
          redirect_to routes.root_path unless self.format == :json
          status 200, { id: note.id }.to_json
        end
      end
    end
  end
end
