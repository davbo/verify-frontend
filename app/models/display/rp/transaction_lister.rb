module Display
  module Rp
    class TransactionLister
      def initialize(proxy, correlator)
        @proxy = proxy
        @correlator = correlator
      end

      def list(translator)
        @correlator.correlate(@proxy.transactions, translator)
      rescue StandardError
        NoTransactions.new
      end

      class NoTransactions
        def any?
          false
        end
      end
    end
  end
end
