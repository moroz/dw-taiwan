defmodule DiamondwayWeb.FormHelpers do
  use Phoenix.HTML
  alias DiamondwayWeb.ErrorHelpers
  import DiamondwayWeb.Gettext

  def text_field(form, field, label \\ [], helper \\ []) do
    content_tag :div, class: field_class(form, field) do
      [
        label(form, field, label, class: "label"),
        content_tag :div, class: "control" do
          text_input(form, field, class: "input")
        end,
        maybe_helper_text(helper),
        ErrorHelpers.error_tag(form, field)
      ]
    end
  end

  defp maybe_helper_text([]), do: ""

  defp maybe_helper_text(text) do
    content_tag(:span, [class: "helper_text"], do: text)
  end

  defp field_class(form, field) do
    case ErrorHelpers.has_error?(form, field) do
      true ->
        "field has-error"

      _ ->
        "field"
    end
  end
end
