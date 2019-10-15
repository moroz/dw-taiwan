defmodule DiamondwayWeb.GraphQLCase do
  defmacro __using__(schema: schema) do
    quote do
      alias Diamondway.Repo

      use ExUnit.Case

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import DiamondwayWeb.GraphQLCase
      import Diamondway.DataCase
      import Diamondway.Factory

      def run_query(document, variables \\ %{}) do
        opts = [variables: normalize_variables(variables)]
        %{data: data} = Absinthe.run!(document, unquote(schema), opts)
        data
      end

      def run_with_user(document, user, variables \\ %{}) do
        context = %{current_user: user}
        opts = [variables: normalize_variables(variables), context: context]
        %{data: data} = Absinthe.run!(document, unquote(schema), opts)
        data
      end

      setup tags do
        :ok = Ecto.Adapters.SQL.Sandbox.checkout(Diamondway.Repo)

        Absinthe.Test.prime(unquote(schema))

        unless tags[:async] do
          Ecto.Adapters.SQL.Sandbox.mode(Diamondway.Repo, {:shared, self()})
        end

        :ok
      end
    end
  end

  def normalize_variables([string | _tail] = list) when is_binary(string), do: list

  def normalize_variables(variables) when is_map(variables) or is_list(variables) do
    Map.new(variables, fn {key, val} -> {camelize_key(key), normalize_variables(val)} end)
  end

  def normalize_variables(atom) when atom in [true, false], do: atom

  def normalize_variables(atom) when is_atom(atom), do: to_string(atom) |> String.upcase()

  def normalize_variables(other), do: other

  def camelize_key(key) do
    to_string(key)
    |> Absinthe.Utils.camelize(lower: true)
  end
end
