#' Get historical data
#' @description This function scraps historical data from CoinMarketCap.com
#' @param id Coin ID as provided by CoinMarketCap.com. Use the `get_ticker()` function to get a full list of availble IDs and coin names.
#' @param from Start date in date format (the default is the day before yesterday)
#' @param to End date in date format (the default is yesterday)
#' @return A tibble with historical data (date, open, high, low, close, volume, market cap) for a specific coin
#' @export
#' @importFrom xml2 read_html
#' @importFrom rvest html_table
#' @importFrom tibble as_tibble

get_historical_data <- function(id, from = NULL, to = NULL) {

  if (is.null(from) & is.null(to)) {
    from <- Sys.Date() - 2
    to <- Sys.Date() - 1
  }

  url <- xml2::read_html(paste0("https://coinmarketcap.com/currencies/", id,
                                "/historical-data/?start=", gsub("-", "", from),
                                "&end=", gsub("-", "", to)))

  out <- as.data.frame(rvest::html_table(url))
  out$Date <- lubridate::mdy(out$Date)
  out$Open <- as.numeric(out$Open)
  out$High <- as.numeric(out$High)
  out$Low <- as.numeric(out$Low)
  out$Close <- as.numeric(out$Close)
  out$Volume <- as.numeric(gsub(",", "", as.character(out$Volume)))
  out$Market.Cap <- as.numeric(gsub(",", "", as.character(out$Market.Cap)))

  colnames(out) <- c("date", "open", "high", "low", "close", "volume", "market_cap")

  return(as_tibble(out))
}

#' Get tickers
#' @description Get all coin IDs and names available on CoinMarketCap.com, including current data
#' @param limit Limits the number of tickers to download, starting from the highest ranked coin (default is all coins)
#' @return A tibble with all coin IDs and names available on CoinMarketCap.com
#' @export
#' @importFrom jsonlite fromJSON
#' @importFrom tibble as_tibble
get_ticker <- function(limit = 0) {
  out <- jsonlite::fromJSON(paste0("https://api.coinmarketcap.com/v1/ticker/?limit=", limit))
  return(as_tibble(out))
}
