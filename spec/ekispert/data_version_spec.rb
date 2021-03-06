require 'spec_helper'
require 'helper/ekispert/data_version_helper'

RSpec.describe Ekispert::DataVersion do
  include Ekispert::SpecHelper::Config
  include Ekispert::SpecHelper::DataVersion
  describe '.get' do
    before { set_ekispert_default_config }
    it 'DataVersion class' do
      expect(Ekispert::DataVersion.get.class).to eq Ekispert::DataVersion
    end
  end
  describe '.to_data_version' do
    let(:parsed_xml) { Ekispert::Client.send(:parse_xml, data_version_res_body) }
    let(:data_version) { Ekispert::DataVersion.send(:to_data_version, parsed_xml) }
    context 'xml contains two "Version" elements and one "Copyrights" element' do
      it '@version_list size eq 2' do
        expect(data_version.version_list.size).to eq 2
      end
      it '@copyrights_list size eq 1' do
        expect(data_version.copyrights_list.size).to eq 1
      end
    end
    context 'Version elements has "create" and "createType" and "caption" attributes' do
      it 'Version instance has "create" method' do
        expect(data_version.version_list[0].create).to eq '20160202'
      end
      it 'Version instance has "create_type" method' do
        expect(data_version.version_list[0].create_type).to eq 'Edition'
      end
      it 'Version instance has "caption" method' do
        expect(data_version.version_list[0].caption).to eq '知識ベース'
      end
    end
    context 'Copyrights elements has "companyId" and "company" attributes' do
      it 'Copyrights instance has "company_id" method' do
        expect(data_version.copyrights_list[0].company_id).to eq '1'
      end
      it 'Copyrights instance has "company" method' do
        expect(data_version.copyrights_list[0].company).to eq 'Example'
      end
    end
    context 'Copyrights elements has text node' do
      it 'Copyrights instance has text method' do
        expect(data_version.copyrights_list[0].text).to eq 'ExampleText'
      end
      it 'Copyrights#to_s return text node' do
        expect(data_version.copyrights_list[0].to_s).to eq 'ExampleText'
      end
    end
    context 'xml contains unexpected element' do
      let(:parsed_xml) { Ekispert::Client.send(:parse_xml, unexpected_res_body) }
      it 'should not raise Exception' do
        expect { Ekispert::DataVersion.send(:to_data_version, parsed_xml) }.not_to raise_error
      end
    end
  end
end
