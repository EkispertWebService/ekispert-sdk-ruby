module Ekispert
  class TrainStationTimetable < EkispertBase
    class LineDestination < EkispertBase
      attr_reader :mark_list

      def initialize(element)
        @mark_list = []
        super(element)
      end

      class Mark < EkispertBase; end
    end
  end
end
