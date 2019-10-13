defmodule Diamondway.Guardian do
  use Guardian, otp_app: :diamondway

  alias Diamondway.Users
  alias Diamondway.Users.User

  def subject_for_token(%User{id: id}, _claims) do
    {:ok, to_string(id)}
  end

  def subject_for_token(_, _), do: {:error, :invalid_resource}

  def resource_from_claims(%{"sub" => user_id}) do
    {:ok, Users.get_user!(user_id)}
  end

  def resource_from_claims(_), do: {:error, :invalid_claims}
end
