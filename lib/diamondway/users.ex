defmodule Diamondway.Users do
  import Ecto.Query, warn: false
  alias Diamondway.Repo
  alias Diamondway.Users.User

  @behaviour Bodyguard.Policy

  def authorize(_, %{admin: true}, _), do: true
  def authorize(:create_user, _, _), do: false
  def authorize(:list_users, _, _), do: false
  def authorize(_, %{id: id}, %{id: id}), do: true
  def authorize(_, _, _), do: false

  def list_users do
    Repo.all(User)
  end

  def get_user!(id), do: Repo.get!(User, id)

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @spec authenticate_user_by_email_password(email :: String.t(), password :: String.t()) ::
          Diamondway.Users.User.t() | nil
  def authenticate_user_by_email_password(email, password) do
    case Repo.get_by(User, email: email) do
      nil ->
        Comeonin.Argon2.dummy_checkpw()
        nil

      %User{password_hash: hash} = user ->
        case Comeonin.Argon2.checkpw(password, hash) do
          true ->
            user

          _ ->
            nil
        end
    end
  end
end
