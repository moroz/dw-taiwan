defmodule DiamondwayWeb.Plugs.SetLocale do
  import Plug.Conn

  require Logger

  def init(default), do: default

  def call(conn, _) do
    locale =
      get_locale_from_params(conn) || get_locale_from_session(conn) ||
        get_locale_from_headers(conn)

    Gettext.put_locale(DiamondwayWeb.Gettext, locale)

    maybe_set_locale_session(conn)
    |> assign(:locale, locale)
  end

  defp get_locale_from_params(conn) do
    Map.get(conn.params, "locale")
  end

  defp maybe_set_locale_session(conn) do
    case get_locale_from_params(conn) do
      nil ->
        conn

      locale ->
        put_session(conn, :locale, locale)
    end
  end

  defp get_locale_from_headers(conn) do
    locale =
      SetLocale.Headers.extract_accept_language(conn)
      |> Enum.find(&String.match?(&1, ~r/(zh|en)/i))

    if locale =~ ~r/zh/i do
      "zh"
    else
      "en"
    end
  end

  defp get_locale_from_session(conn) do
    get_session(conn, :locale)
  end
end
