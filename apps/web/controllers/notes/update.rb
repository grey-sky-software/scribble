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
          predicate(:array?, message: 'is not an array') do |current|
            current.is_a?(Array)
          end

          required(:body).filled(:str?)
          required(:id).filled(:str?)
          optional(:tags) { filled? & array? }
        end

        def call(params)
          note.update(body: params[:body])
          note.tags.delete

          (params[:tags] || []).each do |tag|
            NoteTag.create(note_id: note.id, user_id: current_user.id, value: tag)
          end

          redirect_to routes.root_path unless self.format == :json
          status 200, { id: note.id }.to_json
        end

        def note
          Note.find(params[:id])
        end
      end
    end
  end
end
