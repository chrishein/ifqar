require 'nokogiri'

module Ifqar
  # Convert XML stats to DailyFundsStats
  class StatsDeserializer
    QUOTES_XPATH = "//Dato[Espacios = '3']".freeze

    def self.deserialze(date, type, xml)
      xml_doc = Nokogiri::XML(xml)

      daily_stats = DailyFundsStats.new(date)
      xml_doc.xpath(QUOTES_XPATH).each do |data|
        daily_stats.funds_quotes << quote_builder(date, type, data)
      end
      daily_stats
    end

    def self.quote_builder(date, type, data_node)
      name = data_node.xpath('Nombre').text
      shares = parse_int(data_node.xpath('QCP').text)
      share_value = parse_float(data_node.xpath('VCP').text) / 1000
      net_asset_value = parse_int(data_node.xpath('PN').text)

      fund = Fund.new(name, type)
      FundQuote.new(fund, date, shares, share_value, net_asset_value)
    end

    def self.parse_float(text)
      text.delete('.').sub(',', '.').to_f
    end

    def self.parse_int(text)
      text.delete('.').sub(',', '.').to_i
    end
  end
end
