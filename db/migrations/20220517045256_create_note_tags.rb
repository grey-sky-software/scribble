Hanami::Model.migration do
  up do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :note_tags do
      column :note_id, 'uuid', null: false
      column :user_id, 'uuid', null: false
      column :value, String, null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end

    execute 'ALTER TABLE note_tags ADD CONSTRAINT note_tags_pkey PRIMARY KEY (note_id, user_id, value)'
  end

  down do
    drop_table :note_tags
  end
end
