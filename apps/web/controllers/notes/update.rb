require './apps/web/mixins/check_authentication'
require './apps/web/validators/action_predicates'
# require './apps/web/mixins/uses_json'

module Web::Controllers::Notes
  # PUT /notes/:id
  # Endpoint that will be hit by the front-end to update the details of a Note object.
  # NOTE: This endpoint is not additive - it will replace the attributes of the Note
  #       with the provided attributes.
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

    def call(_)
      update_note
      redirect_to routes.root_path unless self.format == :json
      status 200, { id: note_id }.to_json
    end

    def note
      id = params[:id]
      halt 404 unless Note.exist?(id: id)
      Note.find(id)
    end

    def note_id
      note.id
    end

    def tags
      tags_val = params[:tags]
      return [] if tags_val.blank?
      tags_val
    end

    def update_note
      Note.transaction do
        note.update(body: params[:body])
        note.tags.delete

        tags.each do |tag|
          NoteTag.create(note_id: note_id, user_id: current_user.id, value: tag)
        end
      end
    end
  end
end
