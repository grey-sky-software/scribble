Hanami::Model.migration do
  up do
    alter_table(:notes) do
      add_column :title, String, null: false, unique: false
    end
  end

  down do
    alter_table(:notes) do
      drop_column :title
    end
  end
end
