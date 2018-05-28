require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course do
  include Ekispert::SpecHelper::Config
  include UtilHelper

  describe '.get' do
    before { set_ekispert_default_config }
    # From: Tokyo , To: Chiba
    context 'params = { viaList: "22828:22361" }' do
      let(:course_list) { Ekispert::Course.get(viaList: '22828:22361') }
      it 'return Array and contain Ekispert::Course instance' do
        expect(course_list[0].class).to eq Ekispert::Course
      end
    end
  end
  describe '.to_course' do
    # From: Tokyo, To: Chiba
    context 'use course/simple_search.xml' do
      let(:xml) { read_xml('course/simple_search.xml') }
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
      let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
      let(:course) { course_list[0] }
      it 'return Array and contains two elements' do
        expect(course_list.size).to eq 2
      end
      describe 'Course instance' do
        describe '#search_type' do
          it 'return departure' do
            expect(course.search_type).to eq 'departure'
          end
        end
      end
    end
  end
end
