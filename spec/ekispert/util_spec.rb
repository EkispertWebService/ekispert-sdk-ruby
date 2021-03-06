require 'spec_helper'

RSpec.describe Ekispert::Util do
  include Ekispert::Util
  describe '.snakecase' do
    context 'str = "Station"' do
      it 'return "station"' do
        expect(snakecase('Station')).to eq 'station'
      end
    end
    context 'str = "DataVersion"' do
      it 'return "data_version"' do
        expect(snakecase('DataVersion')).to eq 'data_version'
      end
    end
    context 'str = "data_version"' do
      it 'return "data_version"' do
        expect(snakecase('data_version')).to eq 'data_version'
      end
    end
  end
end
