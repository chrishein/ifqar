module Ifqar
  # Daily Funds Stats
  class DailyFundsStats
    attr_accessor :date, :funds_quotes

    def initialize(date)
      @date = date
      @funds_quotes = []
    end
  end
end
