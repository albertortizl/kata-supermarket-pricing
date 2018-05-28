defmodule SupermarketKata.Parser.StockCSVTest do
  use ExUnit.Case

  alias SupermarketKata.Stock
  alias SupermarketKata.Parser.StockCSV, as: Parser

  test "should parse stock from a valid csv" do
    stock = Parser.parse!("test/resources/stock.csv")
    assert stock == %Stock{
             currency: "$",
             items: %{
               "Avocado" => %{price: 10.0, key: "Avocado"},
               "Kiwi"    => %{price: 6.0, key: "Kiwi"},
               "Potato"  => %{price: 2.0, key: "Potato"},
               "Tomato"  => %{price: 4.0, key: "Tomato"}
             }
           }

  end

  test "should fail parsing a stock from an invalid csv" do
    assert_raise RuntimeError, "oops, impossible to parse stock line 'Potato2$'", fn ->
      Parser.parse!("test/resources/invalid_stock.csv")
    end
  end

  test "should fail parsing a stock from a csv with more than one currency" do
    assert_raise RuntimeError, "oops, more than one currency in the stock '$£'", fn ->
      Parser.parse!("test/resources/multi_currency_stock.csv")
    end
  end

end