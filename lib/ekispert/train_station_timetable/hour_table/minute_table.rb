module Ekispert
  class TrainStationTimetable < EkispertBase
    class HourTable < EkispertBase
      class MinuteTable < EkispertBase
        attr_reader :minute_list, :stop_list

        def initialize(element)
          @minute_list = []
          @stop_list = []
          super(element)
        end

        def minute
          @minute_list[0].text
        end

        def stop
          @stop_list[0]
        end

        class Minute < EkispertBase; end
      end
    end
  end
end
