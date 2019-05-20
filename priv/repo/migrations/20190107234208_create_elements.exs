defmodule Nygma.Repo.Migrations.CreateElements do
  use Ecto.Migration

  def change do
    create table(:nygma_elements) do
      add :predicate, :string, null: false
      add :type, :string, null: false
      add :href, :string, null: true
      add :text, :string, null: true
    end
  end
end
