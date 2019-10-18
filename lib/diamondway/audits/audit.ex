defmodule Diamondway.Audits.Audit do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(description guest_id user_id)a

  schema "audits" do
    belongs_to :guest, Diamondway.Guests.Guest
    belongs_to :user, Diamondway.Users.User
    field :description, :string
    field :timestamp, :utc_datetime, read_after_writes: true
  end

  @doc false
  def changeset(audit, attrs) do
    audit
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
