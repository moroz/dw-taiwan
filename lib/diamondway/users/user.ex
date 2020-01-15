defmodule Diamondway.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :display_name, :string
    field :email, :string
    field :password_hash, :string
    field :avatar_url, :string
    field :human, :boolean
    field :admin, :boolean

    field(:password, :string, virtual: true)

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:display_name, :email, :password, :avatar_url])
    |> validate_required([:display_name, :email, :password])
    |> unique_constraint(:email)
    |> encrypt_password()
  end

  defp encrypt_password(%{valid?: true} = changeset) do
    case get_change(changeset, :password) do
      nil ->
        changeset

      password ->
        encrypted_password = Comeonin.Argon2.hashpwsalt(password)
        put_change(changeset, :password_hash, encrypted_password)
    end
  end

  defp encrypt_password(changeset), do: changeset
end
