require 'spec_helper'
require './lib/ifqar.rb'

RSpec.describe Ifqar::FundQuoter do
  before(:all) do
    @date = Date.parse('14-03-2017')
    @type = :EQUITY
  end

  it 'returns a FundQuote instance with data from an XML representation' do
    quoter = Ifqar::FundQuoter.new
    VCR.use_cassette('stats') do
      stats = quoter.stats(@date, @type)
      expect(stats.funds_quotes.size).to be 98
    end
  end
end
