require 'rest-client'
require 'nokogiri'
require 'open-uri'

module Ifqar
  # Fund Quoter is the client that retrieves quotes from cafci.org.ar
  class FundQuoter
    FUND_TYPE = {
      :EQUITY => { :id => 1, :name => 'Renta Variable' },
      :FIXED_INCOME => { :id => 2, :name => 'Renta Fija' },
      :MONEY_MARKET => { :id => 3, :name => 'Mercado de Dinero' },
      :BALANCED => { :id => 4, :name => 'Renta Mixta' }
    }.freeze

    HEADERS = {
      :multipart => true,
      :referer => 'http://www.cafci.org.ar/scripts/cfn_EstadisticasVCP.html'
    }.freeze

    SET_PARAMS_URL = 'http://www.cafci.org.ar/Scripts/cfn_EstadisticaVCPXMLSet.asp'.freeze
    QUERY_URL = 'http://www.cafci.org.ar/Scripts/cfn_PlanillaDiariaXMLList.asp'.freeze

    def initialize
      @daily_stats = {}
    end

    def stats(date, type)
      date_str = date.strftime('%Y-%m-%d')
      stats = cached_stats(date_str, type)
      if stats.nil?
        stats = query_service(date, type)
        @daily_stats[date_str] = {} if @daily_stats[date_str].nil?
        @daily_stats[date_str][type] = stats
      end
      stats
    end

    def query_service(date, type)
      payload = payload_builder(date, type)
      response = RestClient.post(SET_PARAMS_URL, { :query => payload }, HEADERS)
      response = RestClient.post(QUERY_URL, nil, HEADERS.merge(:cookies => response.cookies))

      StatsDeserializer.deserialze(date, FUND_TYPE[type][:name], response.body)
    end

    def payload_builder(date, type)
      Nokogiri::XML::Builder.new do |xml|
        xml.Coleccion do
          xml.Parametros do
            xml.TRentaI FUND_TYPE[type][:id]
            xml.TRentaN URI.encode(FUND_TYPE[type][:name])
            xml.Fecha date.strftime('%Y-%m-%d')
            xml.Separador 'P'
          end
        end
      end.doc.root.serialize(save_with: 0)
    end

    def cached_stats(date, type)
      return nil if @daily_stats[date].nil? || @daily_stats[date][type].nil?
      @daily_stats[date][type]
    end
  end
end
