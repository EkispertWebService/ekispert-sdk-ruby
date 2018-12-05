module Ekispert
  class TrainStationTimetable < EkispertBase
    class Information < EkispertBase
      attr_reader :line_list, :type_list

      def initialize(element)
        @line_list = []
        @type_list = []
        super(element)
      end

      class Type < EkispertBase; end
    end
  end
end
