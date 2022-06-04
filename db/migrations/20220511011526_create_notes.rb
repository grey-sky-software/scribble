Hanami::Model.migration do
  up do
    # from hanami doc on UUID https://guides.hanamirb.org/v1.3/repositories/postgresql/
    execute 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp"'

    create_table :notes do
      # primary key definition
      primary_key :id, :uuid, null: false, default: Hanami::Model::Sql.function(:uuid_generate_v4)
      column :user_id, :uuid, null: false
      column :body, 'jsonb', null: false

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end

  down do
    drop_table :notes
  end
end
