Hanami::Model.migration do
  up do
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :users do
      primary_key :id, 'uuid',
        null: false, default: Hanami::Model::Sql.function(:uuid_generate_v4)
      column :email, String, unique: true, index: true, null: false
      column :pw_hash, String, null: false
      column :pw_reset_token, String, null: true
      column :pw_reset_token_sent_at, String, null: true
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end

  down do
    drop_table :users
    execute 'DROP EXTENSION IF EXISTS "uuid-ossp"'
  end
end
