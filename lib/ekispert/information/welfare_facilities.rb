module Ekispert
  class Information < EkispertBase
    class WelfareFacilities < EkispertBase
      attr_reader :name_list, :comment_list

      def initialize(element)
        @name_list = []
        @comment_list = []
        super(element)
      end

      def name
        @name_list[0]&.text
      end

      def comment
        @comment_list[0]&.text
      end

      class Name < EkispertBase; end
      class Comment < EkispertBase; end
    end
  end
end
