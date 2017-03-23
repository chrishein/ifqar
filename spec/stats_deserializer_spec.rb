require 'spec_helper'
require './lib/ifqar.rb'

RSpec.describe Ifqar::StatsDeserializer do
  before(:all) do
    @date = Date.parse('14-03-2017')
    @type = 'Renta Variable'
  end

  it 'returns a FundQuote instance with data from an XML representation' do
    xml = <<-EOF
      <Dato>
          <Nombre>Alpha Acciones - Clase C</Nombre>
          <Fecha>14/03/2017</Fecha>
          <Horiz>Lar
          </Horiz>
          <VCP>309,423</VCP>
          <QCP>77.996.359</QCP>
          <PN>24.133.878</PN>
          <Espacios>3</Espacios>
      </Dato>
    EOF

    data_node = Nokogiri::XML(xml).xpath('/*').first
    fund_quote = Ifqar::StatsDeserializer.quote_builder(@date, @type, data_node)

    expect(fund_quote.fund.name).to eq('Alpha Acciones - Clase C')
    expect(fund_quote.shares).to be 77_996_359
    expect(fund_quote.share_value).to be 0.309423
    expect(fund_quote.net_asset_value).to be 24_133_878
  end

  it 'returns an instance of DailyFundsStats with data from an XML representation' do
    xml_string = File.open('spec/fixtures/daily_stats.xml').read
    daily_stats = Ifqar::StatsDeserializer.deserialze(@date, @type, xml_string)

    expect(daily_stats.funds_quotes.size).to be 98
  end
end
