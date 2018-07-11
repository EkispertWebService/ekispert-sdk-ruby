require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line::DepartureState::Gate do
  include UtilHelper

  let(:xml) { read_xml('course/simple_search.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:gate) { course_list[0].route_list[0].line_list[0].departure_state_list[0].gate_list[0] }

  describe '#geopoint_list' do
    it 'return Array and contains Course::Route::Line::DepartureState::Gate::GeoPoint instance' do
      expect(gate.geopoint_list[0].class).to eq Ekispert::Course::Route::Line::DepartureState::Gate::GeoPoint
    end
  end
  describe '#name_list' do
    it 'return Array and contains Course::Route::Line::DepartureState::Gate::Name instance' do
      expect(gate.name_list[0].class).to eq Ekispert::Course::Route::Line::DepartureState::Gate::Name
    end
  end
end