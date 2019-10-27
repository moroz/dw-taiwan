defmodule DiamondwayWeb.GraphQL.Middleware.TransformErrors do
  @behaviour Absinthe.Middleware

  def call(%{errors: []} = res, _), do: res

  def call(%{errors: errors} = res, _) do
    handle_errors(res, errors)
  end

  def handle_errors(res, [%Ecto.Changeset{} = changeset]) do
    %{res | errors: [], value: %{success: false, errors: transform_errors(changeset), message: join_errors(changeset)}}
  end

  def handle_errors(res, _), do: res

  defp join_errors(changeset) do
    msg = 
    changeset
    |> transform_errors()
    |> Map.values()
    |> Enum.join(".\n")
    "Validation failed: #{msg}"
  end

  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn
      {key, [val]} -> {camelize_key(key), val}
      {key, errors} when is_list(errors) -> {camelize_key(key), Enum.join(errors, " ")}
    end)
    |> Map.new()
  end

  def camelize_key(key) do
    to_string(key)
    |> Absinthe.Utils.camelize(lower: true)
  end

  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
