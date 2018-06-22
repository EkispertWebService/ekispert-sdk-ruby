module Ekispert
  class Point < EkispertBase
    attr_accessor :station_list, :prefecture_list, :geo_point_list

    def initialize(element)
      @station_list = []
      @prefecture_list = []
      @geo_point_list = []
      super(element)
    end

    # parse Point class
    def self.get_station(**params)
      to_point(Ekispert::Client.get('station', params))
    end

    def self.get_station_light(**params)
      binding.pry
      to_point(Ekispert::Client.get('station/light', params))
    end

    private

    def self.to_point(elem_arr)
      elem_arr.xpath('//Point').map { |elem| self.new(elem) }
    end
  end
end
