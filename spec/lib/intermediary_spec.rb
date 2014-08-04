require 'spec_helper'

describe Intermediary do

  after { Intermediary.reset_config }

  it 'stores the configuration' do
    Intermediary.configure do |config|
      config.host = 'some-host.test'
      config.port = 15672
    end

    expect(Intermediary.config.host).to eql 'some-host.test'
    expect(Intermediary.config.port).to eql 15672
  end

  it 'returns set attributes as hash' do

    Intermediary.configure do |config|
      config.host = 'some-host.test'
      config.port = 15672
    end

    expect(Intermediary.config.to_hash).to eql(
      host: 'some-host.test',
      port: 15672,
    )
  end
end
