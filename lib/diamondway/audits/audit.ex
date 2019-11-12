defmodule Diamondway.Audits.Audit do
  use Ecto.Schema
  import Ecto.Changeset

  @required ~w(description guest_id user_id)a
  @cast @required ++ [:ip]

  schema "audits" do
    belongs_to :guest, Diamondway.Guests.Guest
    belongs_to :user, Diamondway.Users.User
    field :description, :string
    field :timestamp, :utc_datetime, read_after_writes: true
    field :ip, EctoNetwork.INET
  end

  @doc false
  def changeset(audit, attrs) do
    audit
    |> cast(attrs, @cast)
    |> validate_required(@required)
  end
end
