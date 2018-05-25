module Ekispert
  class Point
    class Prefecture < EkispertBase
      attr_accessor :name_list

      def initialize(element)
        @name_list = []
        super(element)
      end

      class Name < EkispertBase; end
    end
  end
end