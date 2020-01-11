alias ECPay.Invoice

params = %Invoice{
  timestamp: Timex.now(),
  total: 10,
  customer_email: "k.j.moroz@gmail.com",
  item_name: "測試",
  item_count: "1",
  item_word: "次",
  item_price: "10",
  item_amount: "10"
}

Invoice.request(params)
|> IO.puts()
