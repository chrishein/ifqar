module Ifqar
  # Fund represents an Investment Fund
  class Fund
    attr_accessor :name, :type

    def initialize(name, type)
      @name = name
      @type = type
    end
  end
end
