require './apps/web/mixins/check_authentication'
require './apps/web/validators/action_predicates'
# require './apps/web/mixins/uses_json'

module Web::Controllers::Notes
  # POST /notes
  # This action will be hit by authenticated users to save their newly written note
  # to the database.
  # For importing notes to the database from the user's local storage, see [@TODO]
  class Create
    include CheckAuthentication
    include Web::Action
    # include UsesJson

    before :must_be_authenticated
    before { halt 400 unless params.valid? }
    # before { use_json(self) }

    params Class.new(Hanami::Action::Params) {
      ActionPredicates.init(self)

      validations do
        required(:body) { filled? & json? }
        optional(:tags) { filled? & array? }
      end
    }

    def call(_)
      create_note
      redirect_to routes.root_path unless self.format == :json
      status 201, { id: note.id }.to_json
    end

    def create_note
      Note.transaction do
        user_id = current_user.id
        note = Note.create(body: params[:body], user_id: user_id)

        tags.each do |tag|
          NoteTag.create(note_id: note.id, user_id: user_id, value: tag)
        end
      end
    end

    def tags
      tag_val = params[:tags]
      return [] if tag_val.blank?
      tag_val
    end
  end
end
