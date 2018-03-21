# rCoinMarketCap

Simple R based web scrapper to extract data from the popular cryptocurrency comparison page CoinMarketCap.com

To install the package, run

```
devtools::install_github("ckscheuch/rCoinMarketCap")
library("rCoinMarketCap")
```
## Usage

To get all coin IDs and names available on CoinMarketCap.com including current price data, just type
```
get_ticker()
```

To get get historical data for a specific coin and date range, just use the coin ID from the ticker function
```
get_historical_data(id = "bitcoin", from = "2017-01-01", to = "2018-01-01")
```
