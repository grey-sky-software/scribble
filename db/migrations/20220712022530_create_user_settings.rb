Hanami::Model.migration do
  up do
    create_table :user_settings do
      primary_key :user_id, 'uuid', null: false, unique: true
      foreign_key :user_id, :users, type: 'uuid', name: :user_settings_fk_to_users
      column :value, 'jsonb', null: false
      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false
    end
  end

  down do
    drop_table :user_settings
  end
end
