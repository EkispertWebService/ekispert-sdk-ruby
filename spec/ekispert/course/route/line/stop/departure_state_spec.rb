require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Course::Route::Line::Stop::DepartureState do
  include UtilHelper

  let(:xml) { read_xml('course/add_stop_station.xml') }
  let(:parsed_xml) { Ekispert::Client.send(:parse_xml, xml) }
  let(:course_list) { Ekispert::Course.send(:to_course, parsed_xml) }
  let(:departure_state) { course_list[0].route_list[0].line_list[0].stop_list[0].departure_state_list[0] }

  describe '#datetime_list' do
    it 'should return Array and contains Course::Route::Line::Stop::DepartureState::Datetime instance' do
      expect(departure_state.datetime_list[0].class).to eq Ekispert::Course::Route::Line::Stop::DepartureState::Datetime
    end
  end
  describe '#datetime' do
    it 'should return correct value' do
      expect(departure_state.datetime.strftime('%Y年%02m月%02d日 %H:%M:%S')).to eq '2018年10月05日 12:56:00'
    end
    describe 'when train runs over 2 days' do
      let(:xml) { read_xml('course/add_stop_station_2days.xml') }
      let(:last_departure_state) { course_list[0].route_list[0].line_list[0].stop_list[-1].departure_state_list[0] }
      it 'should return correct value' do
        expect(last_departure_state.datetime.strftime('%Y年%02m月%02d日 %H:%M:%S')).to eq '2018年10月20日 00:15:00'
      end
    end
  end
end
