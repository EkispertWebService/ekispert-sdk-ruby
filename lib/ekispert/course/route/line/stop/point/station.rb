module Ekispert
  class Course < EkispertBase
    class Route < EkispertBase
      class Line < EkispertBase
        class Stop < EkispertBase
          class Point < EkispertBase
            class Station < Point
              attr_accessor :name_list

              def initialize(element)
                @name_list = []
                super(element)
              end

              def name
                @name_list[0].text
              end

              class Name < EkispertBase; end
            end
          end
        end
      end
    end
  end
end
