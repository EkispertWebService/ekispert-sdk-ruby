require 'spec_helper'
require 'helper/util_helper'

RSpec.describe Ekispert::Information::Line do
  include UtilHelper

  describe '.to_information（Line class part）' do
    context 'use information/all_type_search.xml' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, read_xml('information/all_type_search.xml')) }
      let(:information_list) { Ekispert::Information.send(:to_information, parsed_xml) }
      let(:line) { information_list[0].line_list[0] }
      describe 'Ekispert::Information::Line instance' do
        describe '#name_list' do
          it 'contains Ekispert::Information::Line::Name instance' do
            expect(line.name_list[0].class).to eq Ekispert::Information::Line::Name
          end
        end
        describe '#type_list' do
          it 'contains Ekispert::Information::Line::Type instance' do
            expect(line.type_list[0].class).to eq Ekispert::Information::Line::Type
          end
        end
        describe '#type_detail' do
          context 'train' do
            it 'should return nil' do
              expect(line.type_detail).to be nil
            end
          end
          context 'local bus' do
            let(:line) { information_list[1].line_list[4] }
            it 'should return "local"' do
              expect(line.type_detail).to eq 'local'
            end
          end
        end
        describe '#color_list' do
          it 'contains Ekispert::Information::Line::Color instance' do
            expect(line.color_list[0].class).to eq Ekispert::Information::Line::Color
          end
        end
        describe '#corporation' do
          let(:line) { information_list[1].line_list[4] }
          it 'should return Ekispert::Information::Corporation instance' do
            expect(line.corporation.class).to eq Ekispert::Information::Corporation
          end
          describe '#name' do
            it 'should return "渋谷区"' do
              expect(line.corporation.name).to eq '渋谷区'
            end
          end
        end
      end
    end
  end
end
