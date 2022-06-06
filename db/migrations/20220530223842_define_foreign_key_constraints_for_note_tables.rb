Hanami::Model.migration do
  up do
    alter_table(:notes) { add_foreign_key([:user_id], :users, name: :notes_fk_to_users) }

    alter_table(:note_tags) do
      add_foreign_key([:note_id], :notes, name: :note_tags_fk_to_notes)
      add_foreign_key([:user_id], :users, name: :note_tags_fk_to_users)
    end

    alter_table(:note_attachments) do
      add_foreign_key([:note_id], :notes, name: :note_attatchments_fk_to_notes)
    end
  end

  down do
    alter_table(:notes) { drop_foreign_key([:user_id], name: :notes_fk_to_users) }

    alter_table(:note_tags) do
      drop_foreign_key([:note_id],  name: :note_tags_fk_to_notes)
      drop_foreign_key([:user_id],  name: :note_tags_fk_to_users)
    end

    alter_table(:note_attachments) do
      drop_foreign_key([:note_id], name: :note_attatchments_fk_to_notes)
    end
  end
end
