module Ekispert
  class EkispertBase
    include Ekispert::Util

    # argument:
    #   element: XML element (parsed Nokogiri)
    def initialize(element)
      @element = element
      set_methods_from_attributes
      set_method_from_text
      update_class_list_variable
    end

    private

    # Ex. Station class
    #   XML: <Station code = '22828'>...</Station>
    #   @element.attributes = {
    #     'code' => #(Attr:0x3fe7b6a050a4 { name = 'code', value = '22828' })
    #   }
    # result:
    #   Ekispert::Point::Station#code #=> '22828'
    def set_methods_from_attributes
      return if @element.attributes.size == 0
      @element.attributes.each do |name, attribute|
        define_singleton_method(snakecase(name)) { attribute.value }
      end
    end

    # Ex. Station::Name class
    #     XML: <Name>東京</Name>
    # result:
    #   instance.text #=> '東京'
    #   instance.to_s #=> '東京'
    def set_method_from_text
      child_elem = @element.children[0]
      return unless child_elem&.text?
      define_singleton_method(:text) { child_elem.text }
      instance_eval { alias :to_s :text }
    end

    # Ex. Point class (When child elements Station and Prefecture)
    #     XML:
    #       <Point>
    #         <Station></Station>
    #         <Prefecture></Prefecture>
    #       </Point>
    # result:
    #   before:
    #     Ekispert::Point#station_list = []
    #     Ekispert::Point#prefecture_list = []
    #   after:
    #     Ekispert::Point#station_list = [#<Ekispert::Point::Station @...>]
    #     Ekispert::Point#prefecture_list = [#<Ekispert::Point::Prefecture @...>]
    def update_class_list_variable
      @element.children.each do |element|
        elem_name = element.name.to_sym
        next unless self.class.constants.include?(elem_name)
        # Ex. Ekispert::DataVersion.new(element)
        sub_instance = self.class.const_get(elem_name).new(element)
        class_list_name = "#{snakecase(elem_name)}_list"
        # Ex. sub_instance.version_list << sub_instance
        self.send(class_list_name) << sub_instance
      end
    end
  end
end
