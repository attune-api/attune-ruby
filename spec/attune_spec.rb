require 'spec_helper'
describe Attune do
  describe 'client' do
    subject { Attune.client }
    it{ should be_a Attune::Client }
  end
  describe 'defaults' do
    subject { Attune::Default }
    specify { expect(subject.endpoint).to eq 'https://api.attune-staging.co' }
    specify { expect(subject.disabled).to eq false }
  end
  describe 'configure' do
    it "yields with Attune::Default" do
      Attune.configure do |c|
        expect(c).to be Attune::Default
      end
    end
  end
  describe 'test_mode' do
    it "sets correct test options" do
      expect(Attune::Default).to receive(:exception_handler=).with(:mock)
      expect(Attune::Default).to receive(:disabled=).with(true)
      Attune.test_mode!
    end
  end
end
