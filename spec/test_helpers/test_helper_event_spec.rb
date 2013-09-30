require 'spec_helper'

module WebsocketRails
  describe TestHelperEvent do
    it 'is an alias for SpecHelperEvent' do
      TestHelperEvent.should eq(SpecHelperEvent)
    end
  end
end