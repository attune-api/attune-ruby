require 'spec_helper'
describe Attune do
  describe 'client' do
    subject { Attune.client }
    it{ should be_a Attune::Client }
  end
  describe 'defaults' do
    subject { Attune::Default }
    specify { expect(subject.endpoint).to eq 'http://localhost/' }
    specify { expect(subject.disabled).to eq false }
  end
end
