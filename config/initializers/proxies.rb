api_host = ENV.fetch("API_HOST") { raise "An API host must be provided with API_HOST" }
api_client = ApiClient.new(api_host)
AUTHN_REQUEST_PROXY = AuthnRequestProxy.new(api_client)

TRANSACTION_LISTER = Display::Rp::TransactionLister.new(Display::Rp::TransactionsProxy.new(api_client),
                                                        Display::Rp::DisplayDataCorrelator.new)