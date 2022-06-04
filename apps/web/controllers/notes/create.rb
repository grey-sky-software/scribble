require './apps/web/mixins/check_authentication'

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

        #accept :json

        before :must_be_authenticated
        before { halt 400 unless params.valid? }

        params do
          required(:body).filled
        end

        def call(params)
          #self.format = :json

          note = Note.create(body: params[:body], user_id: current_user.id)
          #status 201, { id: note.id }.to_json
          redirect_to routes.root_path
        end
      end
    end
  end
end
