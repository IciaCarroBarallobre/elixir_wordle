defmodule ElixirWordle.Repo.Migrations.CreateWords do
  use Ecto.Migration

  def change do
    create table(:words) do
      add :word, :string, null: false
      add :clue, :string, null: false
      add :description, :text, null: true

      timestamps()
    end

    create unique_index(:words, [:word])
    create constraint(:words, :word_length_must_be_between_3_and_8, check: "length(word) > 2 AND length(word) < 9")
  end
end
