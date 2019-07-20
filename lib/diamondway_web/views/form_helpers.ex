defmodule DiamondwayWeb.FormHelpers do
  use Phoenix.HTML
  alias DiamondwayWeb.ErrorHelpers
  import DiamondwayWeb.Gettext, warn: false

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

  def custom_radio(form, field, label \\ [], options \\ []) do
    content_tag :div, class: field_class(form, field) <> " custom_radio" do
      [
        label(form, field, label, class: "label"),
        content_tag :div, class: "custom_radio__options" do
          for {value, label} <- options do
            escaped_value = html_escape(value)
            input_id = input_id(form, field, escaped_value)

            content_tag :div, class: "custom_radio__group" do
              [
                radio_button(form, field, value),
                content_tag(:label, label, for: input_id)
              ]
            end
          end
        end,
        ErrorHelpers.error_tag(form, field)
      ]
    end
  end

  defp maybe_helper_text([]), do: ""

  defp maybe_helper_text(text) do
    content_tag(:span, [class: "helper_text"], do: [text, {:safe, "<br/>"}])
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
