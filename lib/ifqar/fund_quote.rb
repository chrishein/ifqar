module Ifqar
  # Fund Quote is an Investment Fund Quote for a given date, with
  # amount of shares, shave_value and net asset value
  class FundQuote
    attr_accessor :fund, :date, :shares, :share_value, :net_asset_value

    def initialize(fund, date, shares, share_value, net_asset_value)
      @fund = fund
      @date = date
      @shares = shares
      @share_value = share_value
      @net_asset_value = net_asset_value
    end
  end
end
