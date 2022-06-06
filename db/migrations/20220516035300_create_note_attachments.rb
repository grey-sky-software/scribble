Hanami::Model.migration do
  up do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :note_attachments do
      column :note_id, 'uuid', null: false
      column :filename, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end

    execute 'ALTER TABLE note_attachments ADD CONSTRAINT '\
            'note_attachments_pkey PRIMARY KEY (note_id, filename)'
  end

  down do
    drop_table :note_attachments
  end
end
