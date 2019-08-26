defmodule Diamondway.Countries.Country do
  use Ecto.Schema

  schema "countries" do
    field :name, :string
  end

  defimpl Phoenix.HTML.Safe do
    def to_iodata(%{name: name}), do: name
  end
end
