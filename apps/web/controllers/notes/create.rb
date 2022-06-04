require './apps/web/mixins/check_authentication'
#require './apps/web/mixins/uses_json'

module Web
  module Controllers
    module Notes
      # This action will be hit by authenticated users to save their newly written note
      # to the database.
      #
      # For importing notes to the database from the user's local storage, see [@TODO]
      class Create
        include Web::Action
        include CheckAuthentication
        #include UsesJson

        before :must_be_authenticated
        before { halt 400 unless params.valid? }
        #before { use_json(self) }

        params do
          required(:body).filled
        end

        def call(params)
          body = params[:body]
          begin
            JSON.parse(body)
          rescue
            body = { body: body }.to_json
          end

          note = Note.create(body: body, user_id: current_user.id)

          redirect_to routes.root_path unless self.format == :json
          status 201, { id: note.id }.to_json
        end
      end
    end
  end
end
