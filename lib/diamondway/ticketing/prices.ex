defmodule Diamondway.Ticketing.Prices do
  @prices Application.get_env(:diamondway, :ticket_prices)

  def price_map, do: @prices

  def price(type), do: Map.get(@prices, type)
end
