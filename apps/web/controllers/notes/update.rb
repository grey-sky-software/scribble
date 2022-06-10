require './apps/web/mixins/check_authentication'
require './apps/web/validators/action_predicates'
# require './apps/web/mixins/uses_json'

module Web::Controllers::Notes
  class Update
    include CheckAuthentication
    include Web::Action
    # include UsesJson

    params Class.new(Hanami::Action::Params) {
      ActionPredicates.init(self)

      validations do
        required(:body) { filled? & json? }
        required(:id).filled(:str?)
        optional(:tags) { filled? & array? }
      end
    }

    before :must_be_authenticated
    before { halt 400 unless params.valid? }
    # before { use_json(self) }

    def call(params)
      Note.transaction do
        note.update(body: params[:body])
        note.tags.delete

        tags.each do |tag|
          NoteTag.create(note_id: note.id, user_id: current_user.id, value: tag)
        end
      end

      redirect_to routes.root_path unless self.format == :json
      status 200, { id: note.id }.to_json
    end

    def note
      halt 404 unless Note.exist?(id: params[:id])
      Note.find(params[:id])
    end

    def tags
      return [] if params[:tags].blank?
      params[:tags]
    end
  end
end
