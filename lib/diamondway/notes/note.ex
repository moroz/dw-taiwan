defmodule Diamondway.Notes.Note do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(body user_id guest_id)a

  schema "notes" do
    field :body, :string
    belongs_to :user, Diamondway.Users.User
    belongs_to :guest, Diamondway.Guests.Guest

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
